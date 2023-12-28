function PointMarker(_x, _y, _z) : Marker(undefined, _x, _y, _z) constructor {
	static update_bbox = function () {
		bbox[0] = x - 4
		bbox[1] = y - 4
		bbox[2] = x + 4
		bbox[3] = y + 4
	}
	
	static draw = function () {
		draw_set_alpha(0.5)
		draw_rectangle(x - 2, y - 2, x + 2, y + 2, true)
		draw_set_alpha(1)
	}
}