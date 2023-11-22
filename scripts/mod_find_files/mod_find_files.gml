function mod_find_files(_filename) {
	static files = []
	
	var i = 0
	var _mods = global.mods
	var _key = ds_map_find_first(_mods)
	
	repeat ds_map_size(_mods) {
		var _path = _mods[? _key].path + _filename
		
		if file_exists(_path) {
			files[i++] = _path
		}
		
		_key = ds_map_find_next(_mods, _key)
	}
	
	array_resize(files, i)
	
	return files
}