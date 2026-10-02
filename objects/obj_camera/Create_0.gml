gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_cullmode(cull_counterclockwise);

xto = 0;
yto = 0;
zto = 0;
xfrom = 0;
yfrom = 0;
zfrom = 0;

#region vertex format setup

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_colour();
global.vertex_format = vertex_format_end();

#endregion

view_mat = undefined;
proj_mat = undefined;