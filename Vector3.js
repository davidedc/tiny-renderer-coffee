// Generated by CoffeeScript 1.10.0
var Vector3;

Vector3 = (function() {
  function Vector3(x, y, z) {
    this.coords = new Float32Array(3);
    this.coords[0] = x;
    this.coords[1] = y;
    this.coords[2] = z;
  }

  Vector3.prototype.add = function(vec) {
    var coords;
    coords = this.coords;
    vec = vec.coords;
    coords[0] += vec[0];
    coords[1] += vec[1];
    return coords[2] += vec[2];
  };

  Vector3.prototype.multiply = function(scalar) {
    var coords;
    coords = this.coords;
    coords[0] *= scalar;
    coords[1] *= scalar;
    return coords[2] *= scalar;
  };

  Vector3.prototype.vecmul = function(vec) {
    var coords;
    coords = this.coords;
    vec = vec.coords;
    return new Vector3(coords[1] * vec[2] - (coords[2] * vec[1]), coords[0] * vec[2] - (coords[2] * vec[0]), coords[0] * vec[1] - (coords[1] * vec[0]));
  };

  Vector3.prototype.len = function() {
    var coords, len;
    coords = this.coords;
    len = Math.sqrt(coords[0] * coords[0] + coords[1] * coords[1] + coords[2] * coords[2]);
    return len;
  };

  Vector3.prototype.normalize = function() {
    var coords, len;
    coords = this.coords;
    len = Math.sqrt(coords[0] * coords[0] + coords[1] * coords[1] + coords[2] * coords[2]);
    coords[0] /= len;
    coords[1] /= len;
    coords[2] /= len;
    return this;
  };

  Vector3.prototype.dot = function(vec) {
    var coords;
    coords = this.coords;
    vec = vec.coords;
    return vec[0] * coords[0] + vec[1] * coords[1] + vec[2] * coords[2];
  };

  Vector3.prototype.toString = function() {
    return this.coords + '';
  };

  Vector3.planeNormal = function(ax, ay, az, bx, BY, bz, cx, cy, cz) {
    var ab, ac;
    ab = new Vector3(bx - ax, BY - ay, bz - az);
    ac = new Vector3(cx - ax, cy - ay, cz - az);
    return ab.vecmul(ac);
  };

  return Vector3;

})();

//# sourceMappingURL=Vector3.js.map
