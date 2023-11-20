#region Grid
draw_set_alpha(0.2)

var _width = camera_get_view_width(camera)
var _height = camera_get_view_height(camera)
var _x = camera_get_view_x(camera)
var _y = camera_get_view_y(camera)

// Vertical
var _dx = _x mod grid_size

if _dx < 0 {
	_dx += grid_size
}

var _xx = _x + _dx

repeat -~(_width div grid_size) {
	draw_line(_xx, _y, _xx, _y + _height + grid_size)
	_xx += grid_size
}

// Horizontal
var _dy = _y mod grid_size

if _dy < 0 {
	_dy += grid_size
}

var _yy = _y + _dy

repeat -~(_height div grid_size) {
	draw_line(_x, _yy, _x + _width, _yy)
	_yy += grid_size
}

draw_set_alpha(1)
#endregion