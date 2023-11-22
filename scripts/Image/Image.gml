function Image() : Asset() constructor {
	sprite = -1
	texture = -1
	
	static destroy = function () {
		sprite_delete(sprite)
	}
}