(function() {
  var J, parse, stringify, _ref;
  _ref = require('keyjson'), stringify = _ref.stringify, parse = _ref.parse;
  J = (function() {
    function J(k) {
      this.k = k;
    }
    J.prototype.get = function(k, cb) {
      return this.k.get(stringify(k), cb);
    };
    J.prototype.set = function(k, v, cb) {
      return this.k.set(stringify(k), v, cb);
    };
    J.prototype.getRange = function(constraints, cb) {
      var c2;
      c2 = {};
      if (constraints.k__prefix) {
        c2.k__prefix = stringify(constraints.k__prefix);
      }
      return this.k.getRange(c2, cb);
    };
    return J;
  })();
  module.exports = {
    J: J,
    JV: J,
    JVR: J
  };
}).call(this);
