function TextItem(_x, _y, _text) : Item(_x, _y) constructor {
	text = _text
	
	width = string_width(_text)
	height = string_width(_text)
	
	static draw = function (_x, _y) {
		draw_text(_x + x, _y + y, text)
	}
}