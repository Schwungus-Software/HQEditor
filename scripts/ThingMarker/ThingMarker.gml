function ThingMarker(_def, _x, _y, _z) : Marker(_def, _x, _y, _z) constructor {
	sprite = -1
	
	if _def != undefined {
		var _image = _def.image
		
		sprite = _image == undefined ? -1 : _image.sprite
	}
	
	flip = false
	persistent = false
	disposable = false
	
	static point_in_bbox = function (_px, _py) {
		var _x1, _y1, _x2, _y2
		
		if sprite == -1 {
			_x1 = x - 4
			_y1 = y - 4
			_x2 = x + 4
			_y2 = y + 4
		} else {
			// TODO: Change this code to account for rotated sprites.
			var _x_scale = flip ? -1 : 1
			
			_x1 = x - sprite_get_xoffset(sprite) * _x_scale
			_y1 = y - sprite_get_yoffset(sprite)
			_x2 = _x1 + sprite_get_width(sprite) * _x_scale
			_y2 = _y1 + sprite_get_height(sprite)
		}
		
		if point_in_rectangle(_px, _py, _x1, _y1, _x2, _y2) {
			bbox = [_x1, _y1, _x2, _y2]
			
			return true
		}
		
		return false
	}
	
	static draw = function () {
		gpu_set_depth(z)
		
		if sprite == -1 {
			draw_set_alpha(0.5)
			draw_rectangle(x - 4, y - 4, x + 4, y + 4, false)
			draw_set_alpha(1)
			
			exit
		}
		
		draw_sprite_ext(sprite, 0, x, y, flip ? -1 : 1, 1, 0, c_white, 1)
	}
}