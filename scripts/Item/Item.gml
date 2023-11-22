function Item(_x, _y) constructor {
	x = _x
	y = _y
	
	width = 16
	height = 16
	
	window = undefined
	
	static on_click = function () {}
	
	static tick = function () {}
	
	static draw = function (_x, _y) {}
	
	static indicators = function (_str) {
		return _str
	}
}