// Generated by CoffeeScript 1.10.0
var CanvasGL;

CanvasGL = (function() {
  function CanvasGL(canvas) {
    this.canvas = canvas;
    this.context = canvas.getContext('2d');
    this.width = canvas.width;
    this.height = canvas.height;
    this.buffer = this.context.createImageData(this.width, this.height);
    this.zbuffer = new Float64Array(this.width * this.height);
  }

  CanvasGL.prototype.put = function() {
    return this.context.putImageData(this.buffer, 0, 0);
  };

  CanvasGL.prototype.set = function(x, y, z, color) {
    var data, height, index, width;
    data = this.buffer.data;
    width = this.buffer.width;
    height = this.buffer.height;
    index = (height - y | 0) * width + (width - x | 0);
    if (this.zbuffer[index] > z + 1) {
      return;
    }
    this.zbuffer[index] = z + 1;
    index *= 4;
    data[index] = color[0];
    data[index + 1] = color[1];
    data[index + 2] = color[2];
    return data[index + 3] = 255;
  };

  CanvasGL.prototype.line = function(x1, y1, x2, y2, color) {
    var derror, dx, dy, error, results, steep, temp, x, y;
    steep = false;
    temp = void 0;
    if (Math.abs(x1 - x2) < Math.abs(y1 - y2)) {
      x1 = [y1, y1 = x1][0];
      x2 = [y2, y2 = x2][0];
      steep = true;
    }
    if (x1 > x2) {
      x1 = [x2, x2 = x1][0];
      y1 = [y2, y2 = y1][0];
    }
    dx = x2 - x1;
    dy = y2 - y1;
    derror = Math.abs(dy / dx);
    error = 0;
    y = y1;
    x = x1;
    results = [];
    while (x <= x2) {
      if (steep) {
        this.set(y, x, 0, color);
      } else {
        this.set(x, y, 0, color);
      }
      error += derror;
      if (error > 0.5) {
        y += y2 > y1 ? 1 : -1;
        error -= 1;
      }
      results.push(x++);
    }
    return results;
  };

  CanvasGL.prototype.triangleSolid = function(ax, ay, az, bx, BY, bz, cx, cy, cz, color) {
    var ab_delta, ab_t, ac_delta, ac_t, bc_delta, bc_t, df, dz, from, fz, h, j, results, temp, to, tz;
    if (ay === BY && ay === cy) {
      return;
    }
    temp = void 0;
    if (ay > BY) {
      ax = [bx, bx = ax][0];
      ay = [BY, BY = ay][0];
    }
    if (ay > cy) {
      ax = [cx, cx = ax][0];
      ay = [cy, cy = ay][0];
    }
    if (BY > cy) {
      bx = [cx, cx = bx][0];
      BY = [cy, cy = BY][0];
    }
    ab_delta = BY - ay;
    ac_delta = cy - ay;
    bc_delta = cy - BY;
    h = ay;
    results = [];
    while (h < cy) {
      ab_t = (h - ay) / ab_delta;
      ac_t = (h - ay) / ac_delta;
      bc_t = (h - BY) / bc_delta;
      from = (1 - ac_t) * ax + ac_t * cx | 0;
      to = (h < BY ? (1 - ab_t) * ax + ab_t * bx : (1 - bc_t) * bx + bc_t * cx) | 0;
      fz = (1 - ac_t) * az + ac_t * cz;
      tz = h < BY ? (1 - ab_t) * az + ab_t * bz : (1 - bc_t) * bz + bc_t * cz;
      dz = tz - fz;
      df = 0;
      j = from;
      while (j <= to) {
        this.set(j, h, fz + dz * df++ / to, color);
        j++;
      }
      j = to;
      while (j <= from) {
        this.set(j, h, fz + dz * df++ / to, color);
        j++;
      }
      results.push(h++);
    }
    return results;
  };

  return CanvasGL;

})();

//# sourceMappingURL=CanvasGL.js.map