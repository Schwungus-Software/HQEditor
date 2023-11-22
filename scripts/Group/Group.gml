function Group(_name, _contents, _from = undefined) constructor {
	name = _name
	contents = []
	from = _from
	
	static get_path = function (_string = "") {
		var _path = name + "/" + _string
		
		if from == undefined {
			return _path
		}
		
		return from.get_path(_path)
	}
	
	path = get_path()
	
	static add_contents = function (_contents) {
		var _images = global.images
		var _materials = global.materials
		var i = 0
	
		repeat array_length(_contents) {
			var _content = _contents[i++]
		
			if is_struct(_content) {
				var _type = _content[$ "type"]
			
				switch _type {
					case "thing":
					case DefTypes.THING:
						_type = DefTypes.THING
					break
				
					case "prop":
					case DefTypes.PROP:
						_type = DefTypes.PROP
					break
				
					case "polygon":
					case DefTypes.POLYGON:
						_type = DefTypes.POLYGON
					break
				
					default:
						_type = DefTypes.NONE
				}
			
				if _type == DefTypes.NONE {
					continue
				}
			
				var _def
			
				switch _type {
					case DefTypes.THING:
						_def = new ThingDef()
					
						with _def {
							type = _content.thing
						
							var _image = _content[$ "image"]
						
							if is_string(_image) {
								_images.load(_image)
							} else {
								_image = ""
							}
						
							image = _images.get(_image)
						}
					break
				
					case DefTypes.PROP:
						_def = new PropDef()
					
						with _def {
							var _material = _content[$ "material"]
						
							if is_string(_material) {
								_materials.load(_material)
							} else {
								_material = ""
							}
						
							material = _materials.get(_material)
						}
					break
				
					case DefTypes.POLYGON:
						_def = new PolygonDef()
					
						with _def {
							var _material = _content[$ "material"]
						
							if is_string(_material) {
								_materials.load(_material)
							} else {
								_material = ""
							}
						
							material = _materials.get(_material)
						}
					break
				}
			
				with _def {
					name = string(_content[$ "def"])
					grid_size = real(_content[$ "grid_size"] ?? grid_size)
					z = real(_content[$ "z"] ?? grid_size)
				}
			
				array_push(contents, _def)
			}
		
			if is_array(_content) {
				if array_length(_content) < 2 {
					continue
				}
			
				var _group_contents = _content[1]
			
				if not is_array(_group_contents) {
					continue
				}
			
				array_push(contents, new Group(string(_content[0]), _content[1], self))
			}
		}
	}
	
	add_contents(_contents)
}