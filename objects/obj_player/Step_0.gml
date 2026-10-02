if (mouse_lock){
	#region regular movement
	if (window_mouse_get_x() != 0 and window_mouse_get_y() != 0){
	    look_dir += (window_mouse_get_x()-window_get_width() / 2) / 10;
	    look_pitch += (window_mouse_get_y() - window_get_height() / 2) / 10;
	    look_pitch = clamp(look_pitch, -89, 89);
	}
	
	window_mouse_set(window_get_width() / 2, window_get_height() / 2);
	
	var scroll = mouse_wheel_down() - mouse_wheel_up();
	camera_distance = max(camera_distance + 30*scroll, 1);
	var dx = 0, dy = 0;
	if (keyboard_check(ord("A"))) {
	    dx += dsin(look_dir) * move_speed;
	    dy += dcos(look_dir) * move_speed;
	}
	if (keyboard_check(ord("D"))) {
	    dx -= dsin(look_dir) * move_speed;
	    dy -= dcos(look_dir) * move_speed;
	}
	
	if (keyboard_check(ord("W"))) {
	    dx += dcos(look_dir) * move_speed;
	    dy -= dsin(look_dir) * move_speed;
	}
	if (keyboard_check(ord("S"))) {
	    dx -= dcos(look_dir) * move_speed;
	    dy += dsin(look_dir) * move_speed;
	}
	
	if (keyboard_check(vk_space)) {
	    col_shape.position.z -= 2;
		if (CheckCollision(obj_model)) {
			zspeed = 10;
		}
	    col_shape.position.z += 2;
	}
	
	col_shape.position.x += dx;
	if (CheckCollision(obj_model)) {
		col_shape.position.x -= dx;
	}
	else {
		x += dx;
	}
	col_shape.position.y += dy;
	if (CheckCollision(obj_model)) {
		col_shape.position.y -= dy;
	}
	else {
		y += dy;
	}
	
	col_shape.position.z += zspeed;
	z += zspeed;
	if (CheckCollision(obj_model) and zspeed <= 0) {
		col_shape.position.z -= zspeed;
		z -= zspeed
		zspeed = 0;
	}
	else {
		zspeed -= 0.5;
	}
	
	#endregion
}
else {
	if (obj_camera.view_mat != undefined and obj_camera.proj_mat != undefined){
		var mouse_ray = screen_to_world(mouse_x, mouse_y, obj_camera.view_mat, obj_camera.proj_mat);
	}
}

if (keyboard_check_pressed(vk_tab)){
	mouse_lock = not mouse_lock;
	window_mouse_set(window_get_width() / 2, window_get_height() / 2);
}

if (keyboard_check_direct(vk_escape)){
    game_end();
}


var view = dbg_view("hallo", true);
dbg_text("hallo");
dbg_view_delete(view);