class CanvasGL

	constructor: (canvas) ->
		@canvas = canvas
		@context = canvas.getContext('2d')
		@width = canvas.width
		@height = canvas.height
		@buffer = @context.createImageData(@width, @height)
		@zbuffer = new Float64Array(@width * @height)

	put: ->
	  @context.putImageData @buffer, 0, 0

	set: (x, y, z, color) ->
	  # rotate the image
	  data = @buffer.data
	  width = @buffer.width
	  height = @buffer.height
	  index = (height - y | 0) * width + (width - x | 0)
	  if @zbuffer[index] > z + 1
	    return
	  @zbuffer[index] = z + 1
	  index *= 4
	  data[index] = color[0]
	  data[index + 1] = color[1]
	  data[index + 2] = color[2]
	  data[index + 3] = 255

	line: (x1, y1, x2, y2, color) ->
	  steep = false
	  temp = undefined
	  if Math.abs(x1 - x2) < Math.abs(y1 - y2)
	    x1 = [
	      y1
	      y1 = x1
	    ][0]
	    x2 = [
	      y2
	      y2 = x2
	    ][0]
	    steep = true
	  if x1 > x2
	    x1 = [
	      x2
	      x2 = x1
	    ][0]
	    y1 = [
	      y2
	      y2 = y1
	    ][0]
	  dx = x2 - x1
	  dy = y2 - y1
	  derror = Math.abs(dy / dx)
	  error = 0
	  y = y1
	  x = x1
	  while x <= x2
	    if steep
	      @set y, x, 0, color
	    else
	      @set x, y, 0, color
	    error += derror
	    if error > 0.5
	      y += if y2 > y1 then 1 else -1
	      error -= 1
	    x++

	triangleSolid: (ax, ay, az, bx, BY, bz, cx, cy, cz, color) ->
	  if ay == BY and ay == cy
	    return
	  # sort the vertices, a, b, c lower-to-upper 
	  temp = undefined
	  if ay > BY
	    # swapping ax & bx; ay & BY
	    ax = [
	      bx
	      bx = ax
	    ][0]
	    ay = [
	      BY
	      BY = ay
	    ][0]
	  if ay > cy
	    ax = [
	      cx
	      cx = ax
	    ][0]
	    ay = [
	      cy
	      cy = ay
	    ][0]
	  if BY > cy
	    bx = [
	      cx
	      cx = bx
	    ][0]
	    BY = [
	      cy
	      cy = BY
	    ][0]
	  ab_delta = BY - ay
	  ac_delta = cy - ay
	  bc_delta = cy - BY
	  h = ay
	  while h < cy
	    ab_t = (h - ay) / ab_delta
	    ac_t = (h - ay) / ac_delta
	    bc_t = (h - BY) / bc_delta
	    from = (1 - ac_t) * ax + ac_t * cx | 0
	    to = (if h < BY then (1 - ab_t) * ax + ab_t * bx else (1 - bc_t) * bx + bc_t * cx) | 0
	    fz = (1 - ac_t) * az + ac_t * cz
	    tz = if h < BY then (1 - ab_t) * az + ab_t * bz else (1 - bc_t) * bz + bc_t * cz
	    dz = tz - fz
	    df = 0
	    j = from
	    while j <= to
	      @set j, h, fz + dz * df++ / to, color
	      j++
	    # if from > to
	    j = to
	    while j <= from
	      @set j, h, fz + dz * df++ / to, color
	      j++
	    h++

