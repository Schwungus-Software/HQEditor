function TitleWindow(_x, _y) : Window(_x, _y) constructor {
	width = 336
	height = 112
	
	add_item(new TextItem(16, 16, $"HQEditor {GM_version}\nA level editor for HQEngine\n\nCan't Sleep <3 Schwungus Software"))
}