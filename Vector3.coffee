class Vector3

	constructor: (x, y, z) ->
		@coords = new Float32Array(3)
		@coords[0] = x
		@coords[1] = y
		@coords[2] = z

	add: (vec) ->
	  coords = @coords
	  vec = vec.coords
	  coords[0] += vec[0]
	  coords[1] += vec[1]
	  coords[2] += vec[2]

	multiply: (scalar) ->
	  coords = @coords
	  coords[0] *= scalar
	  coords[1] *= scalar
	  coords[2] *= scalar

	vecmul: (vec) ->
	  # vector multiply
	  coords = @coords
	  vec = vec.coords
	  new Vector3(coords[1] * vec[2] - (coords[2] * vec[1]), coords[0] * vec[2] - (coords[2] * vec[0]), coords[0] * vec[1] - (coords[1] * vec[0]))

	len: ->
	  coords = @coords
	  len = Math.sqrt(coords[0] * coords[0] + coords[1] * coords[1] + coords[2] * coords[2])
	  len

	normalize: ->
	  coords = @coords
	  len = Math.sqrt(coords[0] * coords[0] + coords[1] * coords[1] + coords[2] * coords[2])
	  coords[0] /= len
	  coords[1] /= len
	  coords[2] /= len
	  this

	dot: (vec) ->
	  coords = @coords
	  vec = vec.coords
	  vec[0] * coords[0] + vec[1] * coords[1] + vec[2] * coords[2]

	toString: ->
	  @coords + ''

	@planeNormal: (ax, ay, az, bx, BY, bz, cx, cy, cz) ->
		ab = new Vector3(bx - ax, BY - ay, bz - az)
		ac = new Vector3(cx - ax, cy - ay, cz - az)
		ab.vecmul ac

