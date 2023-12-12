function PointMarker(_x, _y, _z) : Marker(undefined, _x, _y, _z) constructor {
	static point_in_bbox = function (_px, _py) {
		var _x1 = x - 4
		var _y1 = y - 4
		var _x2 = x + 4
		var _y2 = y + 4
		
		if point_in_rectangle(_px, _py, _x1, _y1, _x2, _y2) {
			bbox = [_x1, _y1, _x2, _y2]
			
			return true
		}
		
		return false
	}
	
	static draw = function () {
		draw_set_alpha(0.5)
		draw_rectangle(x - 2, y - 2, x + 2, y + 2, true)
		draw_set_alpha(1)
	}
}