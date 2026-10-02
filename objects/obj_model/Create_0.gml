switch (col_type) {
case ColShapes.Point:
	col_shape = new ColPoint(new Vector3(x, y, z)); 
break;
case ColShapes.Sphere:
	col_shape = new ColSphere(new Vector3(x, y, z), x_scale); 
break;
case ColShapes.AABB:
	col_shape = new ColAABB(new Vector3(x, y, z), new Vector3(x_scale, y_scale, z_scale)); 
break;
case ColShapes.Plane:
	col_shape = new ColPlane(new Vector3(0, 0, 1), z); 
break;
default:
	col_shape = undefined;
break;
}

function IsCollidable(inst) {
	if (inst.object_index != obj_model and not object_is_ancestor(inst.object_index, obj_model)) {
		return false
	}
	if (inst.col_shape == undefined) {
		return false
	}
	if (inst == id) {
		return false;
	}
	return true;
}

function IsColliding(inst) { // instance
	if (not IsCollidable(inst)) {
		return false;
	}
	
	return col_shape.CheckCollision(inst.col_shape);
}

function CheckCollision(obj) { // object, array, ALL
	if (typeof(obj) == "array") {
		for (var i = 0; i < array_length(obj); i++) {
			var inst = obj[i];
			if (IsColliding(inst)) {
				return inst;
			}
		}
	}
	else { // object or ALL
		for (var i = 0; i < instance_number(obj); i++) {
			var inst = instance_find(obj, i);
			if (IsColliding(inst)) {
				return inst;
			}
		}
	}
	
	return noone
}