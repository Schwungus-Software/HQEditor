function GroupWindow(_x, _y, _group) : Window(_x, _y) constructor {
	var _path = _group.path
	
	width = 32
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
		height += 108
		
		add_item(new ButtonItem(8, _yy + 10, "Areas", method({
			y: _yy,
			window: _window,
		}, function () {
			window.link_window(new AreasWindow(window.width + 2, y))
		})))
		
		add_item(new ButtonItem(8, _yy + 42, "New", undefined))
		add_item(new ButtonItem(8, _yy + 64, "Open", undefined))
		add_item(new ButtonItem(8, _yy + 86, "Save", undefined))
	}
}