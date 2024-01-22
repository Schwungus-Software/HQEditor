function Marker(_def, _x, _y, _z) constructor {
	priority = 0
	def = _def
	
	x = _x
	y = _y
	z = _z
	bbox = [0, 0, 0, 0]
	
	children = []
	parent = undefined
	
	tag = 0
	
	if _def != undefined {
		var _special = _def.special
		
		if is_struct(_special) {
			special = struct_copy(_special, {})
		}
	}
	
	
	static update_bbox = function () {}
	
	static point_in_bbox = function (_px, _py) {
		update_bbox()
		
		if point_in_rectangle(_px, _py, bbox[0], bbox[1], bbox[2], bbox[3]) {
			return true
		}
		
		return false
	}
	
	static update_child = function (_marker, _removed) {}
	
	static add = function (_marker) {
		area.add(_marker)
		_marker.parent = self
		array_push(children, _marker)
		
		return _marker
	}
	
	static remove = function () {
		while array_length(children) {
			children[0].remove()
		}
		
		if parent != undefined {
			var _children = parent.children
			var i = 0
			
			repeat array_length(_children) {
				var _child = _children[i]
			
				if _child == self {
					array_delete(_children, i, 1)
					parent.update_child(self, true)
				
					break
				}
			
				++i
			}
		}
		
		var _markers = area.markers
		var i = 0
		
		repeat array_length(_markers) {
			var _marker = _markers[i]
			
			if _marker == self {
				array_delete(_markers, i, 1)
				
				return true
			}
			
			++i
		}
		
		return false
	}
	
	static draw = function () {}
}