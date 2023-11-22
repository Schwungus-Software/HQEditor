function ImageItem(_x, _y, _image, _width = undefined, _height = undefined) : Item(_x, _y) constructor {
	sprite = is_instanceof(_image, Image) ? _image.sprite : -1
	width = _width ?? sprite_get_width(sprite)
	height = _height ?? sprite_get_height(sprite)
	
	static draw = function (_x, _y) {
		if sprite == -1 {
			exit
		}
		
		draw_sprite_stretched(sprite, 0, _x + x, _y + y, width, height)
	}
}