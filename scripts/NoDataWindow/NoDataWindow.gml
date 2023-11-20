function NoDataWindow(_x, _y) : Window(_x, _y) constructor {
	width = 480
	height = 240
	popup = false
	
	add_item(new TextItem(16, 16, $"HQEngine data directory not found!\nYour current directory is '{global.config.data_directory}'"))
	
	add_item(new ButtonItem(16, 208, "Change Directory", function () {
		var _config = global.config
		var _new = get_string("Enter", _config.data_directory)
		
		_config.data_directory = _new
		config_save()
		close()
		
		if not directory_exists(_new) {
			global.window = new NoDataWindow(16, 16)
		}
	}))
}