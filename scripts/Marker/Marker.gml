function Marker(_def, _x, _y, _z) constructor {
	def = _def
	
	x = _x
	y = _y
	z = _z
	bbox = [0, 0, 0, 0]
	
	children = []
	parent = undefined
	
	tag = 0
	special = struct_copy(_def.special, {})
	
	static update_bbox = function () {}
	
	static point_in_bbox = function (_px, _py) {
		update_bbox()
		
		if point_in_rectangle(_px, _py, bbox[0], bbox[1], bbox[2], bbox[3]) {
			return true
		}
		
		return false
	}
	
	static remove = function () {}
	
	static draw = function () {}
}