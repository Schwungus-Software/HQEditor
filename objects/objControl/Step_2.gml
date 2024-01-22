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
	
	cursor_x = mouse_x
	cursor_y = mouse_y
	
	if update_highlight or _px != cursor_x or _py != cursor_y {
		if array_length(global.queue_points) {
			global.highlighted = undefined
		} else {
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
							ds_priority_add(_highlight_priority, _marker, z + priority)
						}
					}
				}
			
				global.highlighted = ds_priority_find_max(_highlight_priority)
				ds_priority_clear(_highlight_priority)
			}
		}
		
		update_highlight = false
	}
	
	if not keyboard_check(vk_shift) {
		var _grid_size = global.grid_size
		
		cursor_x = round(mouse_x / _grid_size) * _grid_size
		cursor_y = round(mouse_y / _grid_size) * _grid_size
	}
	
	var _highlighted = global.highlighted
	
	if _highlighted == undefined {
		if mouse_check_button_pressed(mb_left) or (keyboard_check(vk_alt) and mouse_check_button(mb_left)) {
			// Don't place if a window was closed on the last frame.
			if not global.window_step {
				var _current_area = global.current_area
				
				if _current_area != undefined {
					var _current_def = global.current_def
					
					if _current_def != undefined {
						var _z = _current_def.z
					
						if is_instanceof(_current_def, ThingDef) {
							_current_area.add(new ThingMarker(_current_def, cursor_x, cursor_y, _z))
						} else if is_instanceof(_current_def, PropDef) {
							_current_area.add(new PropMarker(_current_def, cursor_x, cursor_y, _z))
						} else if is_instanceof(_current_def, LineDef) or is_instanceof(_current_def, PolygonDef) {
							var _queue_points = global.queue_points
							var n = array_length(_queue_points)
							var _push = true
						
							if n {
								var p = _queue_points[0]
							
								if p[0] == cursor_x and p[1] == cursor_y {
									_current_area.add_polygon(_current_def, _queue_points)
									array_resize(_queue_points, 0)
									_push = false
								}
							}
						
							if _push {
								array_push(global.queue_points, [cursor_x, cursor_y])
							}
						}
					
						update_highlight = true
					}
				}
			}
		} else {
			global.window_step = false
		}
		
		if mouse_check_button_pressed(mb_right) {
			var _queue_points = global.queue_points
			
			if array_length(_queue_points) {
				array_resize(_queue_points, 0)
			}
			
			update_highlight = true
		}
	} else {
		if mouse_check_button_pressed(mb_left) {
			global.window = new MarkerWindow(window_mouse_get_x(), window_mouse_get_y(), _highlighted)
		} else if mouse_check_button_pressed(mb_middle) {
			global.current_def = _highlighted.def
		} else if mouse_check_button_pressed(mb_right) or (keyboard_check(vk_alt) and mouse_check_button(mb_right)) {
			_highlighted.remove()
			update_highlight = true
		}
	}
	
	if keyboard_check_pressed(vk_space) {
		var _queue_points = global.queue_points
		var n = array_length(_queue_points)
		
		if n {
			global.current_area.add_polygon(global.current_def, _queue_points)
			array_resize(global.queue_points, 0)
		} else {
			global.window = new GroupWindow(window_mouse_get_x(), window_mouse_get_y(), global.root_group)
		}
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