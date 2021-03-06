// Generated by CoffeeScript 1.10.0
var Model;

Model = (function() {
  function Model(content) {
    this.content = content;
  }

  Model.prototype.verts = function() {
    var array, content, count, i, l, offset, split;
    offset = this.content.indexOf('#');
    count = this.content.substr(offset).split(' ')[1] | 0;
    content = this.content.split('#')[0].split('\n');
    array = new Float64Array(count * 3);
    i = 0;
    l = content.length;
    while (i < l) {
      split = content[i].split(' ');
      array[i * 3] = split[1];
      array[i * 3 + 1] = split[2];
      array[i * 3 + 2] = split[3];
      i++;
    }
    return array;
  };

  Model.prototype.faces = function() {
    var array, content, count, i, l, offset, split;
    offset = this.content.lastIndexOf('#');
    count = this.content.substr(offset).split(' ')[1] | 0;
    content = this.content.split('f').slice(1).join('f').split('\n');
    array = new Float64Array(count * 3);
    l = content.length;
    while (l--) {
      if (content.pop()[0] === '#') {
        break;
      }
    }
    l = content.length;
    i = 0;
    while (i < l) {
      split = content[i].split('/');
      array[i * 3] = split[0].substr(2) - 1;
      array[i * 3 + 1] = split[2].split(' ')[1] - 1;
      array[i * 3 + 2] = split[4].split(' ')[1] - 1;
      i++;
    }
    return array;
  };

  return Model;

})();

//# sourceMappingURL=Model.js.map
