#region Current Def Under Cursor
var _current_area = global.current_area

if _current_area != undefined {
	with _current_area {
		var i = 0
		
		repeat array_length(markers) {
			markers[i++].draw()
		}
	}
	
	var _highlighted = global.highlighted
	
	if _highlighted != undefined {
		with _highlighted {
			draw_set_alpha(0.5)
			draw_rectangle(bbox[0], bbox[1], bbox[2], bbox[3], true)
			draw_set_alpha(1)
		}
	} else {
		var _queue_points = global.queue_points
		var n = array_length(_queue_points)
		
		if n {
			var i = n
			
			repeat i {
				--i
				
				var _p1 = _queue_points[i]
				var j = -~i
				
				if j >= n {
					draw_line_color(_p1[0], _p1[1], cursor_x, cursor_y, c_yellow, c_yellow)
					
					continue
				}
				
				var _p2 = _queue_points[j]
				
				draw_line_color(_p1[0], _p1[1], _p2[0], _p2[1], c_orange, c_orange)
			}
		}
		
		if global.window == undefined {
			var _current_def = global.current_def
			
			if _current_def != undefined {
				var _image = undefined
				var _primitive = false
				
				if is_instanceof(_current_def, ThingDef) {
					_image = _current_def.image
				} else if is_instanceof(_current_def, PropDef) {
					_image = _current_def.material.image
				} else if is_instanceof(_current_def, LineDef) or is_instanceof(_current_def, PolygonDef) {
					_primitive = true
					_image = _current_def.material.image
				}
				
				draw_set_alpha(0.5)
				
				if is_instanceof(_image, Image) {
					var _sprite = _image.sprite
					
					if _primitive {
						draw_sprite_stretched(_sprite, 0, 2 - cursor_x, 2 - cursor_y, 4, 4)
					} else {
						draw_sprite(_sprite, 0, cursor_x, cursor_y)
					}
				} else {
					draw_rectangle_color(cursor_x - 2, cursor_y - 2, cursor_x + 2, cursor_y + 2, c_yellow, c_yellow, c_yellow, c_yellow, false)
				}
		
				draw_set_alpha(1)
			}
		}
	}
}
#endregion

#region Grid
if show_grid {
	draw_set_alpha(0.2)

	var _width = camera_get_view_width(camera)
	var _height = camera_get_view_height(camera)
	var _x = camera_get_view_x(camera)
	var _y = camera_get_view_y(camera)
	var _grid_size = global.grid_size

	// Vertical
	var _dx = _x mod _grid_size

	if _dx < 0 {
		_dx += _grid_size
	}

	var _xx = _x - _dx

	repeat -~(_width div _grid_size) {
		draw_line(_xx, _y, _xx, _y + _height + _grid_size)
		_xx += _grid_size
	}

	// Horizontal
	var _dy = _y mod _grid_size

	if _dy < 0 {
		_dy += _grid_size
	}

	var _yy = _y - _dy

	repeat (_height div _grid_size) + 2 {
		draw_line(_x, _yy, _x + _width, _yy)
		_yy += _grid_size
	}

	// Origin
	draw_set_alpha(0.5)
	draw_circle(0, 0, 16, true)
	
	// Bounds
	var _bounds = level_get_property("bounds")
	
	if is_array(_bounds) and array_length(_bounds) >= 4 {
		try {
			draw_rectangle(_bounds[0], _bounds[1], _bounds[2], _bounds[3], true)
		} catch (e) {}
	}
	
	draw_set_alpha(1)
}
#endregion