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
		
		repeat array_length(markers) {
			markers[i++].remove()
		}
		
		ds_map_delete(_areas, slot)
	}
}