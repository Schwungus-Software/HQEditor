function level_clear() {
	struct_clear(global.properties)
	
	var _areas = global.areas
	
	repeat ds_map_size(_areas) {
		var _key = ds_map_find_first(_areas)
		
		_areas[? _key].remove()
	}
	
	global.areas = ds_map_create()
	global.last_name = "Untitled.hql"
	global.current_area = undefined
	global.highlighted = undefined
	array_resize(global.selected, 0)
}