function MarkerWindow(_x, _y, _marker) : Window(_x, _y) constructor {
	width = 136
	
	marker = _marker
	add_item(new TextItem(8, 8, marker.def.name))
	
	if is_instanceof(_marker, ThingMarker) {
		height = 157
		
		add_item(new ButtonItem(8, 38, "Flipped: " + string(_marker.flip), function () {
			with marker {
				flip = not flip
				update_bbox()
			}
			
			update_window()
		}))
		
		add_item(new ButtonItem(8, 60, "Persistent: " + string(_marker.persistent), function () {
			with marker {
				persistent = not persistent
			}
			
			update_window()
		}))
		
		add_item(new ButtonItem(8, 82, "Disposable: " + string(_marker.disposable), function () {
			with marker {
				disposable = not disposable
			}
			
			update_window()
		}))
		
		add_item(new TextItem(8, 104, "Tag:"))
		
		add_item(new InputItem(48, 104, 64, 22, _marker.tag, function (_value) {
			try {
				marker.tag = floor(real(_value))
			} catch (e) {
				return false
			}
			
			return true
		}))
		
		add_item(new ButtonItem(8, 127, "Special", function () {
			link_window(new PropertiesWindow(width + 2, 127, "Special Properties: " + marker.def.name, marker.special))
		}))
	}
	
	static update_window = function () {
		var _parent = parent
		var _child = child
		
		parent = undefined
		child = undefined
		
		var _updated_window = new MarkerWindow(x, y, marker)
		
		if _parent != undefined {
			with _parent {
				child = undefined
				link_window(_updated_window)
			}
			
			_updated_window.popup = false
		}
		
		if _child != undefined {
			_updated_window.link_window(_child)
		}
		
		if global.window == self {
			global.window = _updated_window
		}
		
		close()
		_updated_window.clicked = true
		
		return _updated_window
	}
}