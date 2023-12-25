function GroupWindow(_x, _y, _group) : Window(_x, _y) constructor {
	var _path = _group.path
	
	width = 106
	height = 32
	
	group = _group
	
	var _window = self
	var _contents = _group.contents
	var i = 0
	var _yy = 8
	
	repeat array_length(_contents) {
		var _content = _contents[i++]
		var _name, _prefix
		var _image = -1
		
		if is_instanceof(_content, Group) {
			_prefix = ">"
		} else if is_instanceof(_content, ThingDef) {
			_image = _content.image
			_prefix = is_instanceof(_image, Image) ? "  " : "[T] "
		} else if is_instanceof(_content, PropDef) {
			_image = _content.material.image
			_prefix = is_instanceof(_image, Image) ? "  " : "[PR] "
		} else if is_instanceof(_content, LineDef) {
			_image = _content.material.image
			_prefix = is_instanceof(_image, Image) ? "  " : "[L] "
		} else if is_instanceof(_content, PolygonDef) {
			_image = _content.material.image
			_prefix = is_instanceof(_image, Image) ? "  " : "[PG] "
		}
		
		_name = _prefix + _content.name
		
		add_item(new ButtonItem(8, _yy, _name, method({
			y: _yy,
			content: _content,
			window: _window,
		}, function () {
			if is_instanceof(content, Group) {
				window.link_window(new GroupWindow(window.width + 2, y, content))
			} else {
				global.current_def = content
				global.grid_size = content.grid_size
				window.close()
			}
		})))
		
		add_item(new ImageItem(8, _yy, _image, 16, 16))
		_yy += 22
		width = max(width, string_width(_name) + 16)
		height = max(height, _yy + 8)
	}
	
	if _group == global.root_group {
		height += 130
		
		add_item(new ButtonItem(8, _yy + 10, "Properties", method({
			y: _yy,
			window: _window,
		}, function () {
			var _level_properties = new PropertiesWindow(window.width + 2, y, "Level Properties", global.properties)
			
			window.link_window(_level_properties)
			
			if global.current_area != undefined {
				var _current_area = global.current_area
				var _area_properties = new PropertiesWindow(_level_properties.width + 2, 0, $"Area {_current_area.slot} Properties", _current_area.properties)
				
				_area_properties.popup = false
				_level_properties.link_window(_area_properties)
			}
		})))
		
		_yy += 32
		
		add_item(new ButtonItem(8, _yy, "Areas", method({
			y: _yy,
			window: _window,
		}, function () {
			window.link_window(new AreasWindow(window.width + 2, y))
		})))
		
		_yy += 32
		
		add_item(new ButtonItem(8, _yy, "New", method({
			y: _yy,
			window: _window,
		}, function () {
			window.link_window(new ConfirmNewWindow(window.width + 2, y))
		})))
		
		add_item(new ButtonItem(8, _yy + 22, "Open", function () {
			level_load(get_open_filename_ext("*.hql", global.last_name, global.config.data_directory + "/levels/", "Open..."))
		}))
		
		add_item(new ButtonItem(8, _yy + 44, "Save", function () {
			level_save(get_save_filename_ext("*.hql", global.last_name, global.config.data_directory + "/levels/", "Save As..."))
		}))
	}
}