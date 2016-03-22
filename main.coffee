
window.CanvasGL = CanvasGL
window.Model = Model
window.Vector3 = Vector3


ctx = new CanvasGL(document.getElementById('main'))
model = new Model(document.getElementById('model').textContent)
verts = model.verts()
faces = model.faces()
centerx = 300
centery = 300
light_dir = new Vector3(0, 0, 1)
i = 0
l = faces.length
while i < l
  console.log faces[i]
  # index 3 vertices of the triangle
  a = faces[i]
  b = faces[i + 1]
  c = faces[i + 2]
  # We find the coordinates
  ax = (verts[a * 3] + 1) * centerx
  ay = (verts[a * 3 + 1] + 1) * centery
  az = verts[a * 3 + 2]
  bx = (verts[b * 3] + 1) * centerx
  BY = (verts[b * 3 + 1] + 1) * centery
  bz = verts[b * 3 + 2]
  cx = (verts[c * 3] + 1) * centerx
  cy = (verts[c * 3 + 1] + 1) * centery
  cz = verts[c * 3 + 2]
  n = Vector3.planeNormal(verts[a * 3], verts[a * 3 + 1], verts[a * 3 + 2], verts[b * 3], verts[b * 3 + 1], verts[b * 3 + 2], verts[c * 3], verts[c * 3 + 1], verts[c * 3 + 2])
  n.normalize()
  intensity = light_dir.dot(n)
  intensity = intensity * 255 | 0
  if intensity > 0
    ctx.triangleSolid ax, ay, az, bx, BY, bz, cx, cy, bz, [
      intensity
      intensity
      intensity
    ]
  i += 3
ctx.put()

