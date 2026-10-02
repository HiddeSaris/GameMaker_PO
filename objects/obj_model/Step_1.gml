switch (col_type) {
case ColShapes.Point:
	col_shape.position.x = x;
	col_shape.position.y = y;
	col_shape.position.z = z;
break;
case ColShapes.Sphere:
	col_shape.position.x = x;
	col_shape.position.y = y;
	col_shape.position.z = z;
	col_shape.radius = x_scale;
break;
case ColShapes.AABB:
	col_shape.position.x = x;
	col_shape.position.y = y;
	col_shape.position.z = z;
	col_shape.half_extents.x = x_scale;
	col_shape.half_extents.y = y_scale;
	col_shape.half_extents.z = z_scale;
break;
case ColShapes.Plane:
	col_shape.distance = z; 
break;
}