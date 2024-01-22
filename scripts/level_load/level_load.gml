function level_load(_filename) {
	if _filename == "" or not file_exists(_filename) {
		return false
	}
	
	var _buffer = buffer_load(_filename)
	
	if _buffer == -1 {
		global.window = new ErrorWindow(16, 16, "Failed to open file!")
		
		return false
	}
	
	var _header = buffer_read(_buffer, buffer_string)
	
	if _header != HEADER_NAME {
		buffer_delete(_buffer)
		global.window = new ErrorWindow(16, 16, $"Failed to open file!\n'{filename_name(_filename)}' is not a HQEditor level!")
		
		return false
	}
	
	var _major = buffer_read(_buffer, buffer_u8)
	var _minor = buffer_read(_buffer, buffer_u8)
	
	if _major > HEADER_VERSION_MAJOR or _minor > HEADER_VERSION_MINOR {
		buffer_delete(_buffer)
		global.window = new ErrorWindow(16, 16, $"Failed to open file!\nThis version of HQEditor is too old for '{filename_name(_filename)}'!")
		
		return false
	}
	
	level_clear()
	
	var _properties = global.properties
	
	struct_clear(_properties)
	
	var _load_properties = buffer_read_dynamic(_buffer)
	
	struct_copy(_load_properties, _properties)
	
#region Areas
	
	var _defs = global.defs
	var _areas = global.areas
	var _n_areas = buffer_read(_buffer, buffer_u32)
	
	repeat _n_areas {
		var _area = new Area()
		
		with _area {
			slot = buffer_read(_buffer, buffer_u32)
			properties = buffer_read_dynamic(_buffer)
			
#region Polygons
			
			var _n_polygons = buffer_read(_buffer, buffer_u32)
			
			repeat _n_polygons {
				var _def_name = buffer_read(_buffer, buffer_string)
				var _def = _defs[? _def_name]
				
				buffer_read(_buffer, buffer_string) // Unused for editor
				
				var _x = buffer_read(_buffer, buffer_f32)
				var _y = buffer_read(_buffer, buffer_f32)
				var _z = buffer_read(_buffer, buffer_f32)
				var _x_origin = buffer_read(_buffer, buffer_f32)
				var _y_origin = buffer_read(_buffer, buffer_f32)
				var _x_offset = buffer_read(_buffer, buffer_f32)
				var _y_offset = buffer_read(_buffer, buffer_f32)
				var _x_scale = buffer_read(_buffer, buffer_f32)
				var _y_scale = buffer_read(_buffer, buffer_f32)
				var _angle = buffer_read(_buffer, buffer_f32)
				var _layer = buffer_read(_buffer, buffer_u32)
				var _body = buffer_read(_buffer, buffer_bool)
				var _projectile = buffer_read(_buffer, buffer_bool)
				var _vision = buffer_read(_buffer, buffer_bool)
				var _tag = buffer_read(_buffer, buffer_u32)
				var _special = buffer_read_dynamic(_buffer)
				
				var _points = []
				var i = 0
				var n = buffer_read(_buffer, buffer_u32)
				
				repeat n {
					var _px = buffer_read(_buffer, buffer_f32)
					var _py = buffer_read(_buffer, buffer_f32)
					
					array_push(_points, [_px, _py])
				}
				
				with add_polygon(_def, _points) {
					z = _z
				}
			}
			
#endregion
			
#region Lines
			
			var _n_lines = buffer_read(_buffer, buffer_u32)
			
			repeat _n_lines {}
			
#endregion
			
#region Props
			
			var _n_props = buffer_read(_buffer, buffer_u32)
			
			repeat _n_props {
				var _def_name = buffer_read(_buffer, buffer_string)
				var _def = _defs[? _def_name]
				
				buffer_read(_buffer, buffer_string) // Unused for editor
				
				var _x = buffer_read(_buffer, buffer_f32)
				var _y = buffer_read(_buffer, buffer_f32)
				var _z = buffer_read(_buffer, buffer_f32)
				
				var _marker = new PropMarker(_def, _x, _y, _z)
				
				with _marker {
					flip = buffer_read(_buffer, buffer_bool)
					x_scale = buffer_read(_buffer, buffer_f32)
					y_scale = buffer_read(_buffer, buffer_f32)
					angle = buffer_read(_buffer, buffer_f32)
				}
				
				add(_marker)
			}
			
#endregion
			
#region Things
			var _n_things = buffer_read(_buffer, buffer_u32)
			
			repeat _n_things {
				var _def_name = buffer_read(_buffer, buffer_string)
				var _def = _defs[? _def_name]
				
				buffer_read(_buffer, buffer_string) // Unused for editor
				
				var _x = buffer_read(_buffer, buffer_f32)
				var _y = buffer_read(_buffer, buffer_f32)
				var _z = buffer_read(_buffer, buffer_f32)
				
				var _marker = new ThingMarker(_def, _x, _y, _z)
				
				with _marker {
					flip = buffer_read(_buffer, buffer_bool)
					persistent = buffer_read(_buffer, buffer_bool)
					disposable = buffer_read(_buffer, buffer_bool)
					tag = buffer_read(_buffer, buffer_u32)
					special = buffer_read_dynamic(_buffer)
				}
				
				add(_marker)
			}
			
#endregion
			
			ds_map_add(_areas, slot, self)
		}
	}
	
#endregion
	
	buffer_delete(_buffer)
	global.last_name = filename_name(_filename)
}