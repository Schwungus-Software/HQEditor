function Window(_x, _y) constructor {
	x = _x
	y = _y
	
	width = 128
	height = 128
	
	child = undefined
	parent = undefined
	items = []
	popup = true
	
	static handle_close = function () {
		return true
	}
	
	static add_item = function (_item) {
		_item.window = self
		
		array_push(items, _item)
	}
	
	static link_window = function (_window) {
		if child != undefined and not child.close() {
			return false
		}
		
		_window.parent = self
		child = _window
		
		return true
	}
	
	static close = function () {
		if child != undefined {
			if child.close() {
				child = undefined
			} else {
				return false
			}
		}
		
		if not handle_close() {
			return false
		}
		
		if parent != undefined and parent.child == self {
			parent.child = undefined
		}
		
		if global.window == self {
			global.window = undefined
		}
		
		return true
	}
	
	static tick = function () {
		if mouse_check_button_pressed(mb_left) {
			var _mx = window_mouse_get_x()
			var _my = window_mouse_get_y()
			var _x = x
			var _y = y
			
			if popup and not point_in_rectangle(_mx, _my, _x, _y, _x + width, _y + height) {
				close()
				
				exit
			}
			
			var i = 0
			
			repeat array_length(items) {
				with items[i++] {
					var _x1 = x + _x
					var _y1 = y + _y
					
					if point_in_rectangle(_mx, _my, _x1, _y1, _x1 + width, _y1 + height) and on_click != undefined {
						global.item_focus = self
						on_click()
					}
				}
			}
		}
		
		if child != undefined {
			child.tick()
		}
	}
	
	static draw = function (_x, _y) {
		_x += x
		_y += y
		
		draw_rectangle_color(_x, _y, _x + width, _y + height, c_dkgray, c_dkgray, c_dkgray, c_dkgray, false)
		
		var i = 0
		
		repeat array_length(items) {
			items[i++].draw(_x, _y)
		}
		
		if child != undefined {
			child.draw(_x, _y)
		}
	}
}