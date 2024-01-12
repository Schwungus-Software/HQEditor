#region Mods
var _start_window

if directory_exists(global.config.data_directory) {
	reload_assets()
	_start_window = new TitleWindow(16, 16)
} else {
	_start_window = new NoDataWindow(16, 16)
}

global.window = _start_window
global.window_step = false
#endregion

#region Editor
global.current_area = undefined

global.current_def = undefined
global.highlighted = undefined
global.selected = []
global.queue_points = []

highlight_priority = ds_priority_create()
update_highlight = false
show_grid = true
custom_grid = false
custom_grid_size = 16
global.grid_size = 16
cursor_x = 0
cursor_y = 0

camera = view_camera[0]
drag_x = 0
drag_y = 0
zoom = 1

window_width = window_get_width()
window_height = window_get_height()
#endregion