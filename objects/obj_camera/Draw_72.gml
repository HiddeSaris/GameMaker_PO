var camera = camera_get_active();

xto = obj_player.x;
yto = obj_player.y;
zto = obj_player.z;
xfrom = xto - obj_player.camera_distance * dcos(obj_player.look_dir) * dcos(obj_player.look_pitch);
yfrom = yto + obj_player.camera_distance * dsin(obj_player.look_dir) * dcos(obj_player.look_pitch);
zfrom = zto + obj_player.camera_distance * dsin(obj_player.look_pitch);

view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, -1);
proj_mat = matrix_build_projection_perspective_fov(60, window_get_width()/window_get_height(), 1, 32000);

camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);
camera_apply(camera);