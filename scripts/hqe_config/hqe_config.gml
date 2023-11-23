#macro CONFIG_PATH game_save_id + "config.json"

var _config = {
	data_directory: undefined,
}

var _config_json = CONFIG_PATH

if file_exists(_config_json) {
	var _buffer = buffer_load(_config_json)
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