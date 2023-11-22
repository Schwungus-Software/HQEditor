function GroupWindow(_x, _y, _group) : Window(_x, _y) constructor {
	var _path = _group.path
	
	width = max(32, string_width(_path) + 16)
	height = 32
	
	group = _group
	
	add_item(new TextItem(8, 8, _path))
	
	var _window = self
	var _contents = _group.contents
	var i = 0
	var _yy = 30
	
	repeat array_length(_contents) {
		var _content = _contents[i++]
		var _name, _prefix
		
		if is_instanceof(_content, Group) {
			_prefix = ">"
		} else if is_instanceof(_content, ThingDef) {
			_prefix = "[T] "
		} else if is_instanceof(_content, PropDef) {
			_prefix = "[PR] "
		} else if is_instanceof(_content, PolygonDef) {
			_prefix = "[PG] "
		}
		
		_name = _prefix + _content.name
		
		add_item(new ButtonItem(8, _yy, _name, method({
			x: _x,
			y: _y,
			content: _content,
			window: _window,
		}, function () {
			window.close()
			
			if is_instanceof(content, Group) {
				global.window = new GroupWindow(x, y, content)
			}
		})))
		
		_yy += 20
		width = max(width, string_width(_name) + 16)
		height = max(height, _yy + 8)
	}
}