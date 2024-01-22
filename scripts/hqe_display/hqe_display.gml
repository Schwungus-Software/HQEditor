#macro COLOR_INVERSE 0.003921568627451 // 1/255

application_surface_enable(false)
application_surface_draw_enable(false)
surface_free(application_surface)

vertex_format_begin()
vertex_format_add_position_3d() // 3 * 4 (f32)
vertex_format_add_normal() // 3 * 4 (f32)
vertex_format_add_texcoord() // 2 * 4 (f32)
vertex_format_add_colour() // 1 * 4 (u8)
global.vbo_format = vertex_format_end()

gpu_set_texrepeat(true)