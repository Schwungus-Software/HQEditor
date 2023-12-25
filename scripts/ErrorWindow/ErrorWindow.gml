function ErrorWindow(_x, _y, _error) : Window(_x, _y) constructor {
	width = 336
	height = 112
	
	add_item(new TextItem(16, 16, _error))
}