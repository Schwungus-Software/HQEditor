function struct_copy(_src, _dest) {
	gml_pragma("forceinline")
	
	var _names = struct_get_names(_src)
	var i = 0
	
	repeat struct_names_count(_src) {
		var _name = _names[i]
		
		_dest[$ _name] = _src[$ _name];
		++i
	}
	
	return _dest
}