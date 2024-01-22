function Area() constructor {
	slot = noone
	markers = []
	properties = {}
	
	static remove = function () {
		var _areas = global.areas
		
		if global.current_area == self {
			var _key = ds_map_find_previous(_areas, slot) ?? ds_map_find_next(_areas, slot)
			
			global.current_area = _areas[? _key]
		}
		
		var i = 0
		
		while array_length(markers) {
			markers[0].remove()
		}
		
		ds_map_delete(_areas, slot)
	}
	
	static add = function (_marker) {
		_marker.area = self
		array_push(markers, _marker)
		
		return _marker
	}
	
	static add_polygon = function (_def, _points) {
		var n = array_length(_points)
		
		if n < 3 {
			return undefined
		}
		
		var i = 0
		var _x = 0
		var _y = 0
		var _z = _def.z
		
		repeat n {
			var p = _points[i++]
			
			_x += p[0]
			_y += p[1]
		}
		
		_x /= n
		_y /= n
		
		var _polygon = add(new PolygonMarker(_def, _x, _y, _z))
		
		i = 0
		
		repeat n {
			var p = _points[i++]
			
			_polygon.add(new PointMarker(p[0], p[1], _z));
		}
		
		_polygon.rebuild()
		
		return _polygon
	}
}