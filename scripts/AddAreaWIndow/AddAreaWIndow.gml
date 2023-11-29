function AddAreaWindow(_x, _y) : Window(_x, _y) constructor {
	width = 128
	height = 38
	
	var _input = new InputItem(8, 8, 112, 22, "", function (_value) {
		var _id
		
		try {
			_id = real(_value)
		} catch (e) {
			return false
		}
		
		_id = clamp(floor(_id), 0, 4294967295)
		
		var _areas = global.areas
		
		if ds_map_exists(_areas, _id) {
			return false
		}
		
		var _area = new Area()
		
		_area.slot = _id
		ds_map_add(_areas, _id, _area)
		
		with parent {
			parent.link_window(new AreasWindow(x, y))
		}
		
		return true
	})
	
	add_item(_input)
	_input.set_focus(true)
}