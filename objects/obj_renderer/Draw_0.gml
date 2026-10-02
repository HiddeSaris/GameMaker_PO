matrix_set(matrix_world, matrix_build(obj_camera.xfrom, obj_camera.yfrom, obj_camera.zfrom, 180, 0, 0, 18000, 18000, 18000));
vertex_submit(skybox, pr_trianglelist, sprite_get_texture(spr_skybox, 0));
matrix_set(matrix_world, matrix_build_identity());

vertex_submit(grid, pr_trianglelist, -1);
