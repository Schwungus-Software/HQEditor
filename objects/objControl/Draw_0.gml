var _current_def = global.current_def

if _current_def != undefined {
	var _image = undefined

	if is_instanceof(_current_def, ThingDef) {
		_image = _current_def.image
	} else if is_instanceof(_current_def, PropDef) {
		_image = _current_def.material.image
	} /*else if is_instanceof(_current_def, PolygonDef) {
		_image = _current_def.material.image
	}*/
	
	draw_set_alpha(0.5)
	if is_instanceof(_image, Image) {
		draw_sprite(_image.sprite, 0, cursor_x, cursor_y)
	} else {
		draw_rectangle_color(cursor_x - 2, cursor_y - 2, cursor_x + 2, cursor_y + 2, c_yellow, c_yellow, c_yellow, c_yellow, false)
	}
}

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

var _xx = _x - _dx

repeat -~(_width div grid_size) {
	draw_line(_xx, _y, _xx, _y + _height + grid_size)
	_xx += grid_size
}

// Horizontal
var _dy = _y mod grid_size

if _dy < 0 {
	_dy += grid_size
}

var _yy = _y - _dy

repeat (_height div grid_size) + 2 {
	draw_line(_x, _yy, _x + _width, _yy)
	_yy += grid_size
}

draw_set_alpha(0.5)
draw_circle(0, 0, 16, true)
draw_set_alpha(1)
#endregion