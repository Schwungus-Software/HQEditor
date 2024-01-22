function LineMarker(_def, _x, _y, _z) : Marker(_def, _x, _y, _z) constructor {
	vbo = undefined
	
	layer = 0
	body = true
	projectile = true
	vision = true
	
	static rebuild = function () {
		if vbo != undefined {
			vertex_delete_buffer(vbo)
		}
		
		vbo = vertex_create_buffer()
		vertex_begin(vbo, global.vbo_format)
		
		vertex_end(vbo)
	}
}