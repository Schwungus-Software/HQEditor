var _window = global.window

if _window != undefined {
	_window.tick()
} else {
	if mouse_check_button_pressed(mb_middle) {
		drag_x = window_mouse_get_x()
		drag_y = window_mouse_get_y()
	}

	if mouse_check_button(mb_middle) {
		var _dx = camera_get_view_x(camera)
		var _dy = camera_get_view_y(camera)
		var _x = window_mouse_get_x()
		var _y = window_mouse_get_y()
	
		_dx += (_x - drag_x) * zoom
		_dy += (_y - drag_y) * zoom
		drag_x = _x
		drag_y = _y
		camera_set_view_pos(camera, _dx, _dy)
	}

	var _zoom = mouse_wheel_down() - mouse_wheel_up()

	if _zoom != 0 {
		var _inc = zoom >= 1 ? _zoom * 0.25 : _zoom * 0.1
	
		zoom = clamp(zoom + _inc, 0.1, 10)
		camera_set_view_size(camera, window_width * zoom, window_height * zoom)
	}
}

var _ww = window_get_width()
var _wh = window_get_height()

if window_width != _ww or window_height != _wh {
	window_width = _ww
	window_height = _wh
	camera_set_view_size(camera, _ww * zoom, _wh * zoom)
	
	// Clamp current window position to screen
	_window = global.window
	
	if _window != undefined {
		with _window {
			x = clamp(x, 0, _ww - width)
			y = clamp(y, 0, _wh - height)
		}
	}
}