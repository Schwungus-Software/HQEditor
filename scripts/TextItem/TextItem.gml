function TextItem(_x, _y, _text) : Item(_x, _y) constructor {
	text = string(_text)
	
	width = string_width(text)
	height = string_height(text)
	
	static draw = function (_x, _y) {
		draw_text(_x + x, _y + y, text)
	}
}