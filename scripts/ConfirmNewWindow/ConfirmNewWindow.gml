function ConfirmNewWindow(_x, _y) : Window(_x, _y) constructor {
	width = 64
	height = 30
	
	add_item(new ButtonItem(4, 4, "Do it!", function () {
		level_clear()
		close()
	}))
}