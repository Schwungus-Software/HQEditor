function PolygonMarker(_def, _x, _y, _z) : Marker(_def, _x, _y, _z) constructor {
	priority = -1
	
	vbo = undefined
	
	x_origin = 0
	y_origin = 0
	x_offset = 0
	y_offset = 0
	x_scale = 1
	y_scale = 1
	angle = 0
	layer = 0
	body = true
	projectile = true
	vision = true
	
	static point_in_bbox = function (_px, _py) {
        var inside = false
		var n = array_length(children)
		var i = 0
		
		repeat n {
			var j = i % n
			var k = -~i % n
			var _p1 = children[j]
			var _p2 = children[k]
			var _x1 = _p1.x
	        var _y1 = _p1.y
	        var _x2 = _p2.x
	        var _y2 = _p2.y
			
	        if (_y2 > _py) != (_y1 > _py) {
	            inside ^= _px < (_x1 - _x2) * (_py - _y2) / (_y1 - _y2) + _x2
	        }
			
			++i
	    }
		
	    return inside
	}
	
	static update_child = function (_marker, _removed) {
		if _removed and array_length(children) < 3 {
			remove()
			
			return
		}
		
		rebuild()
	}
	
	static rebuild = function () {
		if vbo != undefined {
			vertex_delete_buffer(vbo)
		}
		
		vbo = vertex_create_buffer()
		vertex_begin(vbo, global.vbo_format)
		
#region polygon_to_triangles
		var polygonSize, triangles, points, polyP, good;
	    var i, j, n, p, A, B, C, x0, y0, x1, y1, x2, y2, x3, y3, x4, y4;
	    
		polygonSize = array_length(children)
	    triangles = []
	    points = []
		polyP = []
	    i = 0
		
	    repeat polygonSize {
	        array_push(polyP, children[i++])
	    }
 
	    // 1. For (n - 3) vertices
	    n = polygonSize
		
	    for (n = polygonSize; n > 3; n -= 1) {
	        //  a. Select first point (random)    
	        array_resize(points, 0)
			
	        for (p = 0; p < n; p++) {
				array_push(points, p)
			}
			
	        repeat p {
	            i = floor(random(array_length(points)))
	            A = points[i]
	            array_delete(points, i, 1)
 
	            //  b. Pick the next two points
	            B = -~A % n
	            C = (A + 2) % n
 
	            //  c. Make a triangle with the selected points
				var pA = polyP[A]
				var pB = polyP[B]
				var pC = polyP[C]
				
	            x0 = pA.x;
	            y0 = pA.y;
	            x1 = pB.x;
	            y1 = pB.y;
	            x2 = pC.x;
	            y2 = pC.y;
 
	            //  d. If triangle is counter-clockwise...
	            if (x1 - x0) * (y2 - y0) + (y0 - y1) * (x2 - x0) < 0 {
	                good = true
					
	                //  ...and if triangle has no vertices within it...
	                for (i = 0; i < n; i++) {
	                    if i != A and i != B and i != C {
							var pp = polyP[i]
							
	                        x3 = pp.x
	                        y3 = pp.y
							
	                        if point_in_triangle(x3, y3, x0, y0, x1, y1, x2, y2) { 
	                            good = false
								
	                            break
	                        }
							
	                        //  ...and if the new edge has no other edges crossing it...
	                        j = -~i % n
							
	                        if j != A and j != B and j != C {
								pp = polyP[j]
	                            x4 = pp.x
	                            y4 = pp.y
 
	                            if lines_intersect(x0, y0, x2, y2, x3, y3, x4, y4, true) != 0 { 
	                                good = false
									
	                                break
	                            }
	                        }
	                    }
	                }
					
	                //  e.  ...then add the triangle to list and remove the unshared vertex
	                if good {
	                    array_push(triangles, x0, y0, x1, y1, x2, y2)
						array_delete(polyP, B, 1)
						
	                    break
	                }
	            }
	        }
	    }
		
	    //  2. There are only three vertices left, so add the final triangle to the list
		var pA = polyP[0]
		var pB = polyP[1]
		var pC = polyP[2]
		
		array_push(triangles, pA.x, pA.y, pB.x, pB.y, pC.x, pC.y)
#endregion
		
		var i = 0
		var _image = -1
		var _tu = 1
		var _tv = 1
		
		if def != undefined {
			var _material = def.material
			
			if _material != undefined {
				with _material {
					if image != -1 {
						_image = image.sprite
					}
				}
			}
		}
		
		if _image != -1 {
			_tu = 1 / sprite_get_width(_image)
			_tv = 1 / sprite_get_height(_image)
		}
		
		repeat array_length(triangles) div 6 {
			var _x1 = triangles[i]
			var _y1 = triangles[-~i]
			var _x2 = triangles[i + 2]
			var _y2 = triangles[i + 3]
			var _x3 = triangles[i + 4]
			var _y3 = triangles[i + 5]
			
			vertex_position_3d(vbo, _x1, _y1, z)
			vertex_normal(vbo, 0, 0, 1)
			vertex_texcoord(vbo, _x1 * _tu, _y1 * _tv)
			vertex_color(vbo, c_white, 1)
			vertex_position_3d(vbo, _x2, _y2, z)
			vertex_normal(vbo, 0, 0, 1)
			vertex_texcoord(vbo, _x2 * _tu, _y2 * _tv)
			vertex_color(vbo, c_white, 1)
			vertex_position_3d(vbo, _x3, _y3, z)
			vertex_normal(vbo, 0, 0, 1)
			vertex_texcoord(vbo, _x3 * _tu, _y3 * _tv)
			vertex_color(vbo, c_white, 1)
			i += 6
		}
		
		vertex_end(vbo)
	}
	
	static draw = function () {
		var _material = undefined
		
		if def != undefined {
			_material = def.material
		}
		
		var _image = -1
		
		if _material != undefined {
			_image = _material.image
		}
		
		if _image != -1 {
			_image = _image.texture
		}
		
		vertex_submit(vbo, pr_trianglelist, _image)
		gpu_set_depth(z)
		draw_set_alpha(0.64)
		
		var _x = x - x_origin
		var _y = y - y_origin
		
		draw_line(_x - 16, _y, _x + 16, _y)
		draw_line(_x, _y - 16, _x, _y + 16)
		draw_set_alpha(1)
	}
}