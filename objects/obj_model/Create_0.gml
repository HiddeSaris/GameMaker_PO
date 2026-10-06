function render() {
    shader_set(shd_dir_light);
    shader_set_uniform_f(
        shader_get_uniform(shd_dir_light, "u_Color"), 
    	colour_get_red(color) / 255, 
    	colour_get_green(color) / 255, 
    	colour_get_blue(color) / 255, 
    	1.0
    );
    
    if (rigid_body == undefined) {
        matrix_set(matrix_world, matrix_build(x, y, z, x_rotation, y_rotation, z_rotation, x_scale, y_scale, z_scale));
    }
    else {
        matrix_set(matrix_world, get_transform(rigid_body.idx));//matrix_multiply(matrix_build(0, 0, 0, 0, 0, 0, x_scale, y_scale, z_scale), get_transform(rigid_body.idx)));
    }
    
    if (texture_sprite == undefined){
    	vertex_submit(model, pr_trianglelist, -1);
    }
    else {
    	vertex_submit(model, pr_trianglelist, sprite_get_texture(texture_sprite, 0));
    }
    
    matrix_set(matrix_world, matrix_build_identity());
    
    shader_reset()
}