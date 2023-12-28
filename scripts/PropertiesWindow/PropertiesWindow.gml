function PropertiesWindow(_x, _y, _title, _properties) : Window(_x, _y) constructor {
	width = 300
	height = 94
	
	title = _title
	properties = _properties
	
	add_item(new TextItem(8, 8, _title))
	
	var _names = struct_get_names(_properties)
	var i = 0
	var _add_y
	var _window = self
	
	repeat array_length(_names) {
		_add_y = height - 62
		
		var _key = _names[i]
		
		var _key_input = new InputItem(8, _add_y, 127, 22, _key, method({
			window: _window,
			key: _key,
		}, function (_value) {
			var _properties = window.properties
			
			if struct_exists(_properties, _value) {
				return false
			}
			
			var _val = _properties[$ key]
			
			struct_remove(_properties, key)
			_properties[$ _value] = _val
			window.update_window()
			
			return true
		}))
		
		var _val = json_stringify(_properties[$ _names[i]])
		
		var _value_input = new InputItem(138, _add_y, 127, 22, _val, method({
			window: _window,
			key: _key,
		}, function (_value) {
			window.add_property(key, _value)
			
			return true
		}))
		
		add_item(_key_input)
		add_item(_value_input)
		
		add_item(new ButtonItem(268, _add_y, "[X]", method({
			window: _window,
			key: _key,
		}, function () {
			struct_remove(window.properties, key)
			window.update_window()
		})))
		
		height += 24;
		++i
	}
	
	add_item(new TextItem(8, height - 54, "Add a new property:"))
	_add_y = height - 30
	
	key_input = new InputItem(8, _add_y, 127, 22, "", function (_value) {
		add_property(_value, value_input.value)
		
		return true
	})
	
	value_input = new InputItem(138, _add_y, 127, 22, "", function (_value) {
		add_property(key_input.value, _value)
		
		return true
	})
	
	add_item(key_input)
	add_item(value_input)
	
	static add_property = function (_key, _value) {
		if _key == "" {
			return false
		}
		
		try {
			_value = json_parse(_value)
			properties[$ _key] = _value
		} catch (e) {
			return false
		}
		
		update_window()
		
		return true
	}
	
	static update_window = function () {
		var _parent = parent
		var _child = child
		
		parent = undefined
		child = undefined
		
		var _updated_window = new PropertiesWindow(x, y, title, properties)
		
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