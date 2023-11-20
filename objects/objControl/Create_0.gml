#region Mods
var _config = {
	data_directory: "",
}

if file_exists("config.json") {
	var _buffer = buffer_load("config.json")
	var _json = buffer_read(_buffer, buffer_text)
	
	buffer_delete(_buffer)
	
	var _loaded_config = json_parse(_json)
	var _names = struct_get_names(_loaded_config)
	var i = 0
	
	repeat struct_names_count(_loaded_config) {
		var _name = _names[i++]
		
		if struct_exists(_config, _name) {
			_config[$ _name] = _loaded_config[$ _name]
		}
	}
}

global.config = _config

var _start_window

if directory_exists(_config.data_directory) {
	// Load everything!!!
	_start_window = new TitleWindow(16, 16)
} else {
	_start_window = new NoDataWindow(16, 16)
}
#endregion

#region Defs
defs = []
#endregion

#region Windows
global.window = _start_window
global.item_focus = undefined
#endregion

#region Editor
grid_size = 16

camera = view_camera[0]
drag_x = 0
drag_y = 0
zoom = 1

window_width = window_get_width()
window_height = window_get_height()
#endregion