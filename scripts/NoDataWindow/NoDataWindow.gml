function NoDataWindow(_x, _y) : Window(_x, _y) constructor {
	width = 400
	height = 96
	popup = false
	
	add_item(new TextItem(16, 16, $"HQEngine data directory not found!\nYour current directory:"))
	
	add_item(new InputItem(16, 64, 256, 16, global.config.data_directory, function (_value) {
		global.config.data_directory = _value
		config_save()
		
		if directory_exists(_value) {
			close()
		}
		
		return true
	}))
}