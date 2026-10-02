camera = instance_create_depth(100, 100, depth, obj_camera);

#region create grid

grid = vertex_create_buffer();
vertex_begin(grid, global.vertex_format);

var s = 128;
for (var i = 0; i < room_width; i+= s){
    for (var j = 0; j < room_height; j+= s){
        var col;
        if ((i+j) % (2*s) == 0){
            col = c_white;
        }
        else{
            col = c_aqua;
        }
        vertex_add_point(grid, i,   j,   0, 0, 0, 1, 0, 0, col, 1);
        vertex_add_point(grid, i+s, j+s, 0, 0, 0, 1, 1, 1, col, 1);
        vertex_add_point(grid, i+s, j,   0, 0, 0, 1, 1, 0, col, 1);
        
        vertex_add_point(grid, i+s, j+s, 0, 0, 0, 1, 1, 1, col, 1);
        vertex_add_point(grid, i,   j,   0, 0, 0, 1, 0, 0, col, 1);
        vertex_add_point(grid, i,   j+s, 0, 0, 0, 1, 0, 1, col, 1);

    }
}

vertex_end(grid);

#endregion

skybox = import_model("meshes/skybox", global.vertex_format);
monkey = import_model("meshes/Monkey", global.vertex_format)

aabb   = import_model("shapes/aabb", global.vertex_format);
plane  = import_model("shapes/plane", global.vertex_format);
point  = import_model("shapes/point", global.vertex_format);
sphere = import_model("shapes/sphere", global.vertex_format);

instance_create_depth(100, 100, depth, obj_model, {z: 50, model: aabb, x_scale: 50, y_scale: 50, z_scale: 50, col_type: ColShapes.AABB });
instance_create_depth(0, 0, depth, obj_model, {z: -10, model: plane, x_scale: 50, y_scale: 50, z_scale: 50, col_type: ColShapes.Plane});
instance_create_depth(200, 100, depth, obj_model, {z: 50, model: point, x_scale: 5, y_scale: 5, z_scale: 5, col_type: ColShapes.Point});
instance_create_depth(100, 200, depth, obj_model, {z: 50, model: sphere, x_scale: 50, y_scale: 50, z_scale: 50, col_type: ColShapes.Sphere});

instance_create_depth(0, 0, depth, obj_player, {
	z: 50,
	x_scale: 50, 
	y_scale: 50, 
	z_scale: 50,
	color: c_lime,
	model: sphere,
	col_type: ColShapes.Sphere
});
instance_create_depth(400, 400, depth, obj_model, {
	z: 50, 
	x_scale: 50, 
	y_scale: 50, 
	z_scale: 50,
    color: c_gray,
	model: monkey,
});