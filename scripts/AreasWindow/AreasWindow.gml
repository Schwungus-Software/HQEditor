function AreasWindow(_x, _y) : Window(_x, _y) constructor {
	width = 100
	height = 38
	
	var _areas = global.areas
	var _key = ds_map_find_first(_areas)
	
	repeat ds_map_size(_areas) {
		//var _area = _areas[? _key]
		
		add_item(new ButtonItem(8, height - 30, $"Area {_key}", function () {
			close()
		}))
		
		height += 22
		_key = ds_map_find_next(_areas, _key)
	}
}