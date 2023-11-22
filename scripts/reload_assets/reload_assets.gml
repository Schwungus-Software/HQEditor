function reload_assets(_recursive = false) {
#region Unload Assets
	global.images.clear()
	global.materials.clear()
	global.root_group = undefined
#endregion

#region Unload Mods
	ds_map_clear(global.mods)
#endregion

#region Load Mods
	var _disabled_mods = json_load("data/disabled.json")

	if not is_array(_disabled_mods) {
		_disabled_mods = []
	}

	var n = array_length(_disabled_mods)
	var _load_mods = []
	var _data_directory = global.config.data_directory + "/"
	var _mod = file_find_first(_data_directory + "*", fa_directory)

	while _mod != "" {
		if directory_exists(_data_directory + _mod) {
			var _enabled = true
			var i = 0
		
			repeat n {
				if _disabled_mods[i++] == _mod {
					print($"! hqe_assets: Mod '{_mod}' is disabled, skipping")
					_enabled = false
				
					break
				}
			}
		
			if _enabled {
				array_push(_load_mods, _mod)
			}
		}
	
		_mod = file_find_next()
	}

	file_find_close()

	array_foreach(_load_mods, function (_element, _index) {
		var _mod = new Mod(_element)
	})
#endregion

#region Load Assets (TODO: Support for multiple editor.json files)
	var _editor_json = mod_find_file("editor.json")
	
	if _editor_json != "" {
		var _json = json_load(_editor_json)
		
		if _json == undefined {
			show_error("!!! reload_assets: 'editor.json' not found", true)
		}
		
		var _json_defs = _json[$ "defs"]
		
		if not is_array(_json_defs) {
			show_error("!!! reload_assets: 'editor.json' 'defs' is missing or not an array", true)
		}
		
		global.root_group = new Group("", _json_defs)
	} else {
		show_error("!!! reload_assets: HOW YOU GONE EDIT WITHOUT 'editor.json' ???", true)
	}
#endregion
}