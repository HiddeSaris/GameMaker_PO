ballshape = CreateSphereShape(1);
planeshape = CreateBoxShape(100, 100, 1);

camera = instance_create_depth(10, 10, depth, obj_camera);

#region create grid

grid = vertex_create_buffer();
vertex_begin(grid, global.vertex_format);

var s = 32;
for (var i = -10*s; i < 10*s; i+= s){
    for (var j = -10*s; j < 10*s; j+= s){
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
monkey = import_model("meshes/Monkey", global.vertex_format);

cube   = import_model("shapes/aabb", global.vertex_format);
plane  = import_model("shapes/plane", global.vertex_format);
point  = import_model("shapes/point", global.vertex_format);
sphere = import_model("shapes/sphere", global.vertex_format);

var planerb = create_body(0, 0, -1, 0, 0, 0, BodyType.STATIC, planeshape, 1);
var player = create_body(0, 0, 5, pi/2, 0, 0, BodyType.DYNAMIC, ballshape, 1);

create_model(cube, -1, 1, 1, 1, 1, 1, 1);
create_model(plane, planerb, 0, 0, -1, 1, 1, 1);
create_model(point, -1, 2, 1, 1, 1, 1, 1);
create_model(sphere, -1, 1, 2, 1, 1, 1, 1);
create_model(monkey, -1, 4, 4, 1, 1, 1, 1);

instance_create_depth(0, 0, depth, obj_player, {
	z: 1,
	x_scale: 1, 
	y_scale: 1, 
	z_scale: 1,
	color: c_lime,
	model: monkey,
	rigid_body: player,
});
