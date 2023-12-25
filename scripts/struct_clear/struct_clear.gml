function struct_clear(_struct) {
	gml_pragma("forceinline")
	
	var _names = struct_get_names(_struct)
	var i = 0
	
	repeat struct_names_count(_struct) {
		struct_remove(_struct, _names[i++])
	}
}