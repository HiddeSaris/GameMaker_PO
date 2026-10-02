function vertex_add_point(vbuffer, xx, yy, zz, nx, ny, nz, u, v, color, alpha){
    vertex_position_3d(vbuffer, xx, yy, zz);
    vertex_normal(vbuffer, nx, ny, nz);
    vertex_texcoord(vbuffer, u, v);
    vertex_color(vbuffer, color, alpha);
}

function save_vbuff(vbuff, filename){
	var vertex_data = buffer_create_from_vertex_buffer(vbuff, buffer_fixed, 1);
	var new_filename = get_save_filename("Vertex Buffer|*.vbuff", filename);
	buffer_save(vertex_data, new_filename);
	buffer_delete(vertex_data);
}

function import_model(name, vertex_format){
	var vbuffer = import_vbuff(name + ".vbuff", vertex_format);
	if (vbuffer == -1){
		var model = import_obj(name + ".obj", vertex_format);
		save_vbuff(model, name + ".vbuff");
		return model
	}
	else{
		return vbuffer;
	}
}

function import_vbuff(filename, vertex_format){
	if (not file_exists(filename)){
		show_debug_message("Warning: file doesn't exist! '" + filename + "'");
		return -1;
	}
	var data = buffer_load(filename);
	
	var model = vertex_create_buffer_from_buffer(data, vertex_format);
	buffer_delete(data);
	return model;
}

function import_obj(filename, vertex_format){
    var buffer = buffer_load(filename);
	if (buffer == -1){
		show_error("Error: file doesn't exist! '" + filename + "'", true)
		return -1;
	}
	
    var content_string = buffer_read(buffer, buffer_text);
    buffer_delete(buffer);
    
    var lines = string_split(content_string, "\n");
    
    var vb = vertex_create_buffer();
    vertex_begin(vb, vertex_format);
    
    var positions = [];
    var texcoords = [];
    var normals   = [];
    
    for (var i = 0; i < array_length(lines); i++) {
        var this_line = lines[i];
        if (this_line == "") continue;
            
        var tokens = string_split(this_line, " ");
        
        switch (tokens[0]){
            case "v":
                var vx = real(tokens[1]);
                var vy = real(tokens[2]);
                var vz = real(tokens[3]);
                array_push(positions, {
                    x: vx, y: vz, z: vy
                });
                break;
            case "vt":
                var tx = real(tokens[1]);
                var ty = real(tokens[2]);
                array_push(texcoords, {
                    x: tx, y: ty
                });
                break;
            case "vn":
                var nx = real(tokens[1]);
                var ny = real(tokens[2]);
                var nz = real(tokens[3]);
                array_push(normals, {
                    x: nx, y: nz, z: ny
                });
                break;
            case "f":
				for (var j = 3; j < array_length(tokens); j++){
	                var v1 = tokens[1];
	                var v2 = tokens[j - 1];
	                var v3 = tokens[j];
					
	                var v1_tokens = string_split(v1, "/");
	                var v2_tokens = string_split(v2, "/");
	                var v3_tokens = string_split(v3, "/");
					
					var v1_position = { x: 0, y: 0, z: 0 };
					var v1_texcoord = { x: 0, y: 0 };
					var v1_normal   = { x: 0, y: 0, z: 0 };
					
					switch (array_length(v1_tokens)) {
						case 1:
							v1_position = positions[real(v1_tokens[0]) - 1];
						break;
						case 2:
							v1_position = positions[real(v1_tokens[0]) - 1];
							v1_texcoord = texcoords[real(v1_tokens[1]) - 1];
						break;
						case 3:
							v1_position = positions[real(v1_tokens[0]) - 1];
							if (v1_tokens[1] != ""){
								v1_texcoord = texcoords[real(v1_tokens[1]) - 1];
							}
							v1_normal   = normals[real(v1_tokens[2]) - 1];
						break;
					}
					
					var v2_position = { x: 0, y: 0, z: 0 };
					var v2_texcoord = { x: 0, y: 0 };
					var v2_normal   = { x: 0, y: 0, z: 0 };
					
	                switch (array_length(v2_tokens)) {
						case 1:
							v2_position = positions[real(v2_tokens[0]) - 1];
						break;
						case 2:
							v2_position = positions[real(v2_tokens[0]) - 1];
							v2_texcoord = texcoords[real(v2_tokens[1]) - 1];
						break;
						case 3:
							v2_position = positions[real(v2_tokens[0]) - 1];
							if (v2_tokens[1] != ""){
								v2_texcoord = texcoords[real(v2_tokens[1]) - 1];
							}
							v2_normal   = normals[real(v2_tokens[2]) - 1];
						break;
					}
					
					var v3_position = { x: 0, y: 0, z: 0 };
					var v3_texcoord = { x: 0, y: 0 };
					var v3_normal   = { x: 0, y: 0, z: 0 };
					
	                switch (array_length(v3_tokens)) {
						case 1:
							v3_position = positions[real(v3_tokens[0]) - 1];
						break;
						case 2:
							v3_position = positions[real(v3_tokens[0]) - 1];
							v3_texcoord = texcoords[real(v3_tokens[1]) - 1];
						break;
						case 3:
							v3_position = positions[real(v3_tokens[0]) - 1];
							if (v3_tokens[1] != ""){
								v3_texcoord = texcoords[real(v3_tokens[1]) - 1];
							}
							v3_normal   = normals[real(v3_tokens[2]) - 1];
						break;
					}
					
	                vertex_add_point(vb, v1_position.x, v1_position.y, v1_position.z, 
	                                v1_normal.x, v1_normal.y, v1_normal.z, 
	                                v1_texcoord.x, v1_texcoord.y,
	                                c_white, 1);
					
	                vertex_add_point(vb, v2_position.x, v2_position.y, v2_position.z, 
	                                v2_normal.x, v2_normal.y, v2_normal.z, 
	                                v2_texcoord.x, v2_texcoord.y,
	                                c_white, 1);
					
	                vertex_add_point(vb, v3_position.x, v3_position.y, v3_position.z, 
	                                v3_normal.x, v3_normal.y, v3_normal.z, 
	                                v3_texcoord.x, v3_texcoord.y,
	                                c_white, 1);
				}
			break;
        }
    }
    
    
    vertex_end(vb);
    //vertex_freeze(vb);
    
    return vb;
}