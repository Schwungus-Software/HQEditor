function AreasWindow(_x, _y) : Window(_x, _y) constructor {
	width = 100
	height = 38
	
	var _areas = global.areas
	var n = ds_map_size(_areas)
	var _key = ds_map_find_first(_areas)
	var _window = self
	
	repeat n {
		// TODO: Select as active area after clicking.
		var _name = $"Area {_key}"
		
		add_item(new ButtonItem(8, height - 30, _name, method({
			slot: _key,
			window: _window,
		}, function () {
			global.current_area = global.areas[? slot]
			window.close()
		})))
		
		width = max(width, string_width(_name) + 16)
		height += 22
		_key = ds_map_find_next(_areas, _key)
	}
	
	if n {
		height += 16
	}
	
	add_item(new ButtonItem(8, height - 30, "Add Area", function () {
		link_window(new AddAreaWindow(width + 2, height - 30))
	}))
}