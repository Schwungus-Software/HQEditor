function Marker(_def, _x, _y, _z) constructor {
	def = _def
	
	x = _x
	y = _y
	z = _z
	bbox = [0, 0, 0, 0]
	
	children = []
	parent = undefined
	
	static point_in_bbox = function (_px, _py) {
		return false
	}
	
	static remove = function () {}
	
	static draw = function () {}
}