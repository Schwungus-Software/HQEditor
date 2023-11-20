function config_save() {
	var _buffer = buffer_create(1, buffer_grow, 1)
	
	buffer_write(_buffer, buffer_text, json_stringify(global.config, true))
	buffer_save(_buffer, "config.json")
	buffer_delete(_buffer)
}