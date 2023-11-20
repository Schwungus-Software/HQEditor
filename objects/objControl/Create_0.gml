#region Defs
defs = []
#endregion

#region Windows
global.window = new TitleWindow(16, 16)
#endregion

#region Editor
grid_size = 16

camera = view_camera[0]
drag_x = 0
drag_y = 0
zoom = 1

window_width = window_get_width()
window_height = window_get_height()
#endregion