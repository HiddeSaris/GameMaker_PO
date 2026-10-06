#macro log show_debug_message
#macro delta_time_seconds (delta_time/1000000)

global.shared_buffer = buffer_create(65536, buffer_fixed, 1);
global.shared_array = array_create(65536, 0)
Init(buffer_get_address(global.shared_buffer), ptr(global.shared_array));
global.world = CreatePhysicsWorld();
SetPhysicsWorldGravity(world, 0, 0, -9.81);
global.rb_index = -1;


function create_body(x, y, z, rx, ry, rz, type, collider, fc = 0.5, bounce = 0.5) {
    var body = CreateRigidbody(global.world, x, y, z, rx, ry, rz);
    SetRigidbodyType(body, type);
    var col = AddCollider(body, collider);
    SetColliderFrictionCoefficient(col, fc);
    SetColliderBounciness(col, bounce)
    buffer_write(global.shared_buffer, buffer_u64, body);
    global.rb_index++;
    return {
        body: body,
        idx: global.rb_index,
    };
}

function create_model(model, rigid_body, x, y, z, xs = 1, ys = 1, zs = 1, xr = 0, yr = 0, zr = 0, color = c_white) {
    if (rigid_body == -1) {rigid_body = undefined}
    return instance_create_depth(x, y, depth, obj_model, { 
        z: z,
        x_rotation: xr,
        y_rotation: yr,
        z_rotation: zr,
        x_scale: xs, 
        y_scale: ys,
        z_scale: zs, 
        color: color, 
        model: model, 
        rigid_body: rigid_body
    });
}

function get_transform(rb_idx) {
    return global.shared_array[rb_idx];
}

function get_transform_euler(body) {
    var angle = GetTransformRotation(body);
    return axis_angle_to_euler(angle.rx, angle.ry, angle.rz, angle.angle);
}

function axis_angle_to_euler(xr, yr, zr, angle) {
    // converted from https://www.euclideanspace.com/maths/geometry/rotations/conversions/angleToEuler/index.htm
    var heading, attitude, bank;
	var s = sin(angle);
	var c = cos(angle);
	var t = 1 - c;
	
	var magnitude = sqrt(xr*xr + yr*yr + zr*zr);
	if (magnitude == 0) return [0, 0, 0];
	xr /= magnitude;
	yr /= magnitude;
	zr /= magnitude;
	if ((xr*yr*t + zr*s) > 0.9999) { // north pole singularity detected
		heading = 2 * arctan2(xr * sin(angle/2), cos(angle/2));
		attitude = pi/2;
		bank = 0;
	}
	else if ((xr*yr*t + zr*s) < -0.9999) { // south pole singularity detected 
        heading = -2 * arctan2(xr * sin(angle/2), cos(angle/2));
		attitude = -pi/2;
		bank = 0;
	}
    else { 
        heading = arctan2(yr * s - xr * zr * t , 1 - (yr*yr+ zr*zr ) * t); 
        attitude = arcsin(xr * yr * t + zr * s);
        bank = arctan2(xr * s - yr * zr * t , 1 - (xr*xr + zr*zr) * t);
    }
    return [radtodeg(-attitude), radtodeg(-heading), radtodeg(-bank)];
}

function convert_2d_to_3d_cam(camera, _x, _y)
{
    /*
    Transforms a 2D coordinate (in window space) to a 3D vector.
    Returns an array of the following format:
    [dx, dy, dz, ox, oy, oz]
    where [dx, dy, dz] is the direction vector and [ox, oy, oz] is the origin of the ray.
    Works for both orthographic and perspective projections.
    Script created by TheSnidr
    */
    var V = camera_get_view_mat(camera);
    var P = camera_get_proj_mat(camera);
    var mx = 2 * (_x / window_get_width()  - .5) / P[0];
    var my = 2 * (_y / window_get_height() - .5) / P[5];
    var camX = - (V[12] * V[0] + V[13] * V[1] + V[14] * V[2]);
    var camY = - (V[12] * V[4] + V[13] * V[5] + V[14] * V[6]);
    var camZ = - (V[12] * V[8] + V[13] * V[9] + V[14] * V[10]);
    if (P[15] == 0)
    {    //This is a perspective projection
        return [V[2]  + mx * V[0] + my * V[1],
                V[6]  + mx * V[4] + my * V[5],
                V[10] + mx * V[8] + my * V[9],
                camX,
                camY,
                camZ];
    }
    else
    {    //This is an ortho projection
        return [V[2],
                V[6],
                V[10],
                camX + mx * V[0] + my * V[1],
                camY + mx * V[4] + my * V[5],
                camZ + mx * V[8] + my * V[9]];
    }
}