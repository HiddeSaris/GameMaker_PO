event_inherited();

if (mouse_lock){
	#region regular movement
	if (window_mouse_get_x() != 0 and window_mouse_get_y() != 0){
	    look_dir += (window_mouse_get_x()-window_get_width() / 2) / 10;
	    look_pitch += (window_mouse_get_y() - window_get_height() / 2) / 10;
	    look_pitch = clamp(look_pitch, -89, 89);
	}
	
	window_mouse_set(window_get_width() / 2, window_get_height() / 2);
	
	var scroll = mouse_wheel_down() - mouse_wheel_up();
	camera_distance = max(camera_distance + 0.5*scroll, 1);
	var dx = 0, dy = 0;
	if (keyboard_check(ord("A"))) {
	    ApplyRigidbodyWorldForceAtCenterOfMass(rigid_body.body, 5*dsin(look_dir), 5*dcos(look_dir), 0)
	}
	if (keyboard_check(ord("D"))) {
	    ApplyRigidbodyWorldForceAtCenterOfMass(rigid_body.body, -5*dsin(look_dir), -5*dcos(look_dir), 0)
	}
	
    log(look_dir);
	if (keyboard_check(ord("W"))) {
	    //ApplyRigidbodyWorldTorque(rigid_body.body, dcos(look_dir), 0, dsin(look_dir));
        ApplyRigidbodyWorldForceAtCenterOfMass(rigid_body.body, 5*dcos(look_dir), -5*dsin(look_dir), 0)
	}
	if (keyboard_check(ord("S"))) {
	    ApplyRigidbodyWorldForceAtCenterOfMass(rigid_body.body, -5*dcos(look_dir), 5*dsin(look_dir), 0)
	}
	
	if (keyboard_check_pressed(vk_space)) {
        ApplyRigidbodyWorldForceAtCenterOfMass(rigid_body.body, 0, 0, 500);
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
