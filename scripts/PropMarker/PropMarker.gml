function PropMarker(_def, _x, _y, _z) : Marker(_def, _x, _y, _z) constructor {
	sprite = -1
	
	if _def != undefined {
		var _image = _def.image
		
		sprite = _image == undefined ? -1 : _image.sprite
	}
	
	flip = false
	x_scale = 1
	y_scale = 1
	angle = 0
	layer = 0
	
	static update_bbox = function () {
		var _x1, _y1, _x2, _y2
		
		if sprite == -1 {
			_x1 = x - 4
			_y1 = y - 4
			_x2 = x + 4
			_y2 = y + 4
		} else {
			// TODO: Change this code to account for rotated sprites.
			var _x_scale = flip ? -x_scale : x_scale
			
			_x1 = x - sprite_get_xoffset(sprite) * _x_scale
			_y1 = y - sprite_get_yoffset(sprite) * y_scale
			_x2 = _x1 + sprite_get_width(sprite) * _x_scale
			_y2 = _y1 + sprite_get_height(sprite) * y_scale
		}
		
		bbox[0] = min(_x1, _x2)
		bbox[1] = min(_y1, _y2)
		bbox[2] = max(_x1, _x2)
		bbox[3] = max(_y1, _y2)
	}
	
	static draw = function () {
		gpu_set_depth(z)
		
		if sprite == -1 {
			draw_set_alpha(0.5)
			draw_rectangle(x - 4, y - 4, x + 4, y + 4, false)
			draw_set_alpha(1)
			
			exit
		}
		
		draw_sprite_ext(sprite, 0, x, y, flip ? -x_scale : x_scale, y_scale, angle, c_white, 1)
	}
}