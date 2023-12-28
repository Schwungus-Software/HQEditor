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
	
	global.window_step = true
} else {
	if keyboard_check_pressed(ord("G")) {
		show_grid = not show_grid
	}
	
	if keyboard_check_pressed(ord("R")) {
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
	
	if update_highlight or _px != cursor_x or _py != cursor_y {
		var _current_area = global.current_area
		
		if _current_area != undefined {
			var _cx = cursor_x
			var _cy = cursor_y
			var _highlight_priority = highlight_priority
			var _markers = _current_area.markers
			var i = 0
			
			repeat array_length(_markers) {
				var _marker = _markers[i++]
				
				with _marker {
					if point_in_bbox(_cx, _cy) {
						ds_priority_add(_highlight_priority, _marker, z)
					}
				}
			}
			
			global.highlighted = ds_priority_find_max(_highlight_priority)
			ds_priority_clear(_highlight_priority)
		}
		
		update_highlight = false
	}
	
	var _highlighted = global.highlighted
	
	if _highlighted == undefined {
		if mouse_check_button_pressed(mb_left) or (keyboard_check(vk_alt) and mouse_check_button(mb_left)) {
			// Don't place if a window was closed on the last frame.
			if not global.window_step {
				var _current_area = global.current_area
				
				if _current_area != undefined {
					var _current_def = global.current_def
				
					if is_instanceof(_current_def, ThingDef) {
						array_push(_current_area.markers, new ThingMarker(_current_def, cursor_x, cursor_y, _current_def.z))
					}
				
					update_highlight = true
				}
			}
		} else {
			global.window_step = false
		}
	} else {
		if mouse_check_button_pressed(mb_left) {
			// Inspect Marker
		}
		
		if mouse_check_button_pressed(mb_right) or (keyboard_check(vk_alt) and mouse_check_button(mb_right)) {
			var _current_area = global.current_area
		
			if _current_area != undefined { // Just to be safe.
				var _markers = _current_area.markers
				var i = 0
				
				repeat array_length(_markers) {
					if _markers[i] == _highlighted {
						break
					}
					
					++i
				}
				
				array_delete(_markers, i, 1)
			}
			
			update_highlight = true
		}
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
			x = clamp(x, 0, other.window_width - width)
			y = clamp(y, 0, other.window_height - height)
		}
	}
}