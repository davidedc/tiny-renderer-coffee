class Model

	constructor: (content) ->
		@content = content

	verts: ->
	  offset = @content.indexOf('#')
	  count = @content.substr(offset).split(' ')[1] | 0
	  content = @content.split('#')[0].split('\n')
	  array = new Float64Array(count * 3)
	  i = 0
	  l = content.length
	  while i < l
	    # v -0.000581696 -0.734665 -0.623267
	    split = content[i].split(' ')
	    array[i * 3] = split[1]
	    array[i * 3 + 1] = split[2]
	    array[i * 3 + 2] = split[3]
	    i++
	  array

	faces: ->
	  offset = @content.lastIndexOf('#')
	  count = @content.substr(offset).split(' ')[1] | 0
	  content = @content.split('f').slice(1).join('f').split('\n')
	  array = new Float64Array(count * 3)
	  l = content.length
	  while l--
	    if content.pop()[0] == '#'
	      break
	  l = content.length
	  i = 0
	  while i < l
	    # f 36/13/36 34/11/34 35/14/35
	    split = content[i].split('/')
	    array[i * 3] = split[0].substr(2) - 1
	    array[i * 3 + 1] = split[2].split(' ')[1] - 1
	    array[i * 3 + 2] = split[4].split(' ')[1] - 1
	    i++
	  array

