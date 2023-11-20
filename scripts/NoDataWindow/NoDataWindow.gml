function NoDataWindow(_x, _y) : Window(_x, _y) constructor {
	width = 480
	height = 240
	popup = false
	
	add_item(new TextItem(16, 16, $"HQEngine directory not found!\nYour current directory is '{"objControl.game_directory"}'\n\nWould you like to change it?"))
	
	add_item(new ButtonItem(16, 208, "Yes", function () {
		self.close()
	}))
	
	add_item(new ButtonItem(64, 208, "No", function () {
		self.close()
	}))
}