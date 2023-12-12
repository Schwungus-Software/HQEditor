var _indicators
var _window = global.window

if _window != undefined {
	_window.draw(0, 0)
	_indicators = _window.indicators("")
	
	var _item_focus = global.item_focus
	
	if _item_focus != undefined {
		_indicators = _item_focus.indicators(_indicators)
	}
} else {
	draw_text(16, 16, $"X: {cursor_x}\nY: {cursor_y}\n{round((1 / zoom) * 100)}%")
	_indicators = "[Space] Menu"
	_indicators += "\n[Shift] Unsnap Cursor (Hold)"
	_indicators += "\n[G] " + (show_grid ? "Hide" : "Show") + " Grid"
	_indicators += "\n[C] Reset View"
}

var _text_y = window_height - 16
var _current_def = global.current_def

draw_set_halign(fa_right)

var _current_area = global.current_area

if _current_area != undefined {
	with _current_area {
		draw_text(other.window_width - 16, 16, $"Area {slot}\n{array_length(markers)} Markers")
	}
	
	draw_set_valign(fa_bottom)
	
	var _highlighted = global.highlighted
	
	if _current_def != undefined {
		var _image = undefined
		
		if is_instanceof(_current_def, ThingDef) {
			_image = _current_def.image
		} else if is_instanceof(_current_def, PropDef) {
			_image = _current_def.material.image
		} else if is_instanceof(_current_def, PolygonDef) {
			_image = _current_def.material.image
		}
		
		if is_instanceof(_image, Image) {
			draw_sprite_stretched(_image.sprite, 0, window_width - 80, window_height - 80, 64, 64)
		} else {
			draw_text(window_width - 16, _text_y, _current_def.name)
		}
	
		if _window == undefined and _highlighted == undefined {
			_indicators += "\n[LMB] Place Marker"
			_indicators += "\n[Alt] Spam Mode (Hold)"
		}
	}
	
	if _window == undefined {
		if _highlighted != undefined {
			_indicators += "\n[LMB] Inspect Marker"
			_indicators += "\n[RMB] Remove Marker"
			_indicators += "\n[Alt] Spam Mode (Hold)"
		}
	}
} else {
	draw_text(window_width - 16, 16, "No Area selected")
}

draw_set_valign(fa_bottom)
draw_set_halign(fa_left)
draw_text_color(16, _text_y, _indicators, c_white, c_white, c_white, c_white, 0.5)
draw_set_valign(fa_top)
