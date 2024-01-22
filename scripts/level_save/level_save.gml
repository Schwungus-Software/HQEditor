function level_save(_filename) {
	if _filename == "" {
		return false
	}
	
	var _buffer = buffer_create(1, buffer_grow, 1)
	
	buffer_write(_buffer, buffer_string, HEADER_NAME)
	buffer_write(_buffer, buffer_u8, HEADER_VERSION_MAJOR) // Major version
	buffer_write(_buffer, buffer_u8, HEADER_VERSION_MINOR) // Minor version
	buffer_write_dynamic(_buffer, global.properties)
	
#region Areas
	var _areas = global.areas
	var n = ds_map_size(_areas)
	
	buffer_write(_buffer, buffer_u32, n)
	
	var _key = ds_map_find_first(_areas)
	
	repeat n {
		var _area = _areas[? _key]
		
		buffer_write(_buffer, buffer_u32, _key)
		
		with _area {
			buffer_write_dynamic(_buffer, properties)
		
#region Markers
			var _polygons = []
			var _lines = []
			var _props = []
			var _things = []
			var _markers = markers
			var i = 0
		
			repeat array_length(_markers) {
				var _marker = _markers[i++]
			
				if is_instanceof(_marker, ThingMarker) {
					array_push(_things, _marker)
				} else if is_instanceof(_marker, PropMarker) {
					array_push(_props, _marker)
				} else if is_instanceof(_marker, LineMarker) {
					array_push(_lines, _marker)
				} else if is_instanceof(_marker, PolygonMarker) {
					array_push(_polygons, _marker)
				}
			}

#region Polygons
			n = array_length(_polygons)
			buffer_write(_buffer, buffer_u32, n)
			i = 0
		
			repeat n {
				var _polygon = _polygons[i]
			
				with _polygon {
					with def {
						buffer_write(_buffer, buffer_string, name)
						
						if material != undefined {
							buffer_write(_buffer, buffer_string, material.name)
						} else {
							buffer_write(_buffer, buffer_string, "")
						}
					}
					
					buffer_write(_buffer, buffer_f32, x)
					buffer_write(_buffer, buffer_f32, y)
					buffer_write(_buffer, buffer_f32, z)
					buffer_write(_buffer, buffer_f32, x_origin)
					buffer_write(_buffer, buffer_f32, y_origin)
					buffer_write(_buffer, buffer_f32, x_offset)
					buffer_write(_buffer, buffer_f32, y_offset)
					buffer_write(_buffer, buffer_f32, x_scale)
					buffer_write(_buffer, buffer_f32, y_scale)
					buffer_write(_buffer, buffer_f32, angle)
					buffer_write(_buffer, buffer_u32, layer)
					buffer_write(_buffer, buffer_bool, body)
					buffer_write(_buffer, buffer_bool, projectile)
					buffer_write(_buffer, buffer_bool, vision)
					buffer_write(_buffer, buffer_u32, tag)
					buffer_write_dynamic(_buffer, special)
					
					var n2 = array_length(children)
					
					buffer_write(_buffer, buffer_u32, n2)
					
					var j = 0
					
					repeat n2 {
						with children[j++] {
							buffer_write(_buffer, buffer_f32, x)
							buffer_write(_buffer, buffer_f32, y)
						}
					}
				}
			
				++i
			}
#endregion

#region Lines
			buffer_write(_buffer, buffer_u32, 0)
#endregion

#region Props
			n = array_length(_props)
			buffer_write(_buffer, buffer_u32, n)
			i = 0
		
			repeat n {
				var _prop = _props[i]
			
				with _prop {
					with def {
						buffer_write(_buffer, buffer_string, name)
						
						if material != undefined {
							buffer_write(_buffer, buffer_string, material.name)
						} else {
							buffer_write(_buffer, buffer_string, "")
						}
					}
					
					buffer_write(_buffer, buffer_f32, x)
					buffer_write(_buffer, buffer_f32, y)
					buffer_write(_buffer, buffer_f32, z)
					buffer_write(_buffer, buffer_bool, flip)
					buffer_write(_buffer, buffer_f32, x_scale)
					buffer_write(_buffer, buffer_f32, y_scale)
					buffer_write(_buffer, buffer_f32, angle)
					buffer_write(_buffer, buffer_u32, layer)
				}
			
				++i
			}
#endregion

#region Things
			n = array_length(_things)
			buffer_write(_buffer, buffer_u32, n)
			i = 0
		
			repeat n {
				var _thing = _things[i]
			
				with _thing {
					with def {
						buffer_write(_buffer, buffer_string, name)
						buffer_write(_buffer, buffer_string, type)
					}
					
					buffer_write(_buffer, buffer_f32, x)
					buffer_write(_buffer, buffer_f32, y)
					buffer_write(_buffer, buffer_f32, z)
					buffer_write(_buffer, buffer_bool, flip)
					buffer_write(_buffer, buffer_bool, persistent)
					buffer_write(_buffer, buffer_bool, disposable)
					buffer_write(_buffer, buffer_u32, tag)
					buffer_write_dynamic(_buffer, special)
				}
			
				++i
			}
#endregion

		}

#endregion
		
		_key = ds_map_find_next(_areas, _key)
	}
#endregion
	
	buffer_save(_buffer, _filename)
	buffer_delete(_buffer)
	global.last_name = filename_name(_filename)
	
	return true
}