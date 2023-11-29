var _window = global.window

if _window != undefined {
	with _window {
		if mouse_check_button(mb_right) {
			x = clamp(window_mouse_get_x(), 0, window_get_width() - width)
			y = clamp(window_mouse_get_y(), 0, window_get_height() - height)
		}
		
		_window.tick()
	}
	
	var _item_focus = global.item_focus
	
	if _item_focus != undefined {
		_item_focus.tick()
	}
} else {
	if keyboard_check_pressed(ord("G")) {
		show_grid = not show_grid
	}
	
	if keyboard_check_pressed(ord("C")) {
		zoom = 1
		camera_set_view_pos(camera, 0, 0)
		camera_set_view_size(camera, window_width, window_height)
	}
	
	if mouse_check_button_pressed(mb_middle) {
		drag_x = window_mouse_get_x()
		drag_y = window_mouse_get_y()
	}

	if mouse_check_button(mb_middle) {
		var _dx = camera_get_view_x(camera)
		var _dy = camera_get_view_y(camera)
		var _x = window_mouse_get_x()
		var _y = window_mouse_get_y()
	
		_dx -= (_x - drag_x) * zoom
		_dy -= (_y - drag_y) * zoom
		drag_x = _x
		drag_y = _y
		camera_set_view_pos(camera, _dx, _dy)
	}

	var _zoom = mouse_wheel_down() - mouse_wheel_up()

	if _zoom != 0 {
		var _inc = zoom >= 1 ? _zoom * 0.2 : _zoom * 0.1
	
		zoom = clamp(zoom + _inc, 0.1, 10)
		camera_set_view_size(camera, window_width * zoom, window_height * zoom)
	}
	
	var _px = cursor_x
	var _py = cursor_y
	
	if keyboard_check(vk_shift) {
		cursor_x = mouse_x
		cursor_y = mouse_y
	} else {
		var _grid_size = global.grid_size
		
		cursor_x = round(mouse_x / _grid_size) * _grid_size
		cursor_y = round(mouse_y / _grid_size) * _grid_size
	}
	
	if _px != cursor_x or _py != cursor_y {
		// Highlight marker under cursor
	}
	
	if keyboard_check_pressed(vk_space) {
		global.window = new GroupWindow(window_mouse_get_x(), window_mouse_get_y(), global.root_group)
	}
}

var _ww = window_get_width()
var _wh = window_get_height()

if window_width != _ww or window_height != _wh {
	window_width = clamp(_ww, 320, display_get_width())
	window_height = clamp(_wh, 200, display_get_height())
	window_set_size(window_width, window_height)
	camera_set_view_size(camera, window_width * zoom, window_height * zoom)
	
	// Clamp current window position to screen
	_window = global.window
	
	if _window != undefined {
		with _window {
			x = clamp(x, 0, window_width - width)
			y = clamp(y, 0, window_height - height)
		}
	}
}