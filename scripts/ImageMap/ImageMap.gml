function ImageMap() : AssetMap() constructor {
	static load = function (_name) {
		if ds_map_exists(assets, _name) {
			exit
		}
		
		var _path = "images/" + _name
		var _frames = 1
		var _x_offset = 0
		var _y_offset = 0
		var _json = json_load(mod_find_file(_path + ".json"))
		
		if _json != undefined {
			_frames = _json[$ "frames"] ?? 1
			_x_offset = _json[$ "x_offset"] ?? 0
			_y_offset = _json[$ "y_offset"] ?? 0
		}
		
		var _png_file = mod_find_file(_path + ".png")
		
		if _png_file != "" {
			var _sprite = sprite_add(_png_file, _frames, false, false, _x_offset, _y_offset)
			
			with new Image() {
				name = _name
				sprite = _sprite
				texture = sprite_get_texture(_sprite, 0)
				ds_map_add(other.assets, _name, self)
				print($"ImageMap.load: Added '{_name}' ({self})")
			}
		} else {
			print($"! ImageMap.load: '{_name}' not found")
		}
	}
}

global.images = new ImageMap()