function level_get_property(_key, _area = global.current_area) {
	gml_pragma("forceinline")
	
	if _area != undefined {
		var _properties = _area.properties
		
		if struct_exists(_properties, _key) {
			return _properties[$ _key]
		}
	}
	
	return global.properties[$ _key]
}