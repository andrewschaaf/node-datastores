(function() {
  var Mock, dec, enc, normalize, startswith;
  var __hasProp = Object.prototype.hasOwnProperty;
  normalize = function(k) {
    if (k instanceof Buffer) {
      return k;
    } else {
      return new Buffer(k);
    }
  };
  enc = function(k) {
    return k.toString('base64');
  };
  dec = function(b64) {
    return new Buffer(b64, 'base64');
  };
  startswith = function(buf1, buf2) {
    var i, _ref;
    if (buf2.length > buf1.length) {
      return false;
    }
    for (i = 0, _ref = buf2.length; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
      if (buf1[i] !== buf2[i]) {
        return false;
      }
    }
    return true;
  };
  Mock = (function() {
    function Mock() {
      this.items = {};
    }
    Mock.prototype.get = function(k, cb) {
      var v;
      k = normalize(k);
      v = this.items[enc(k)] || null;
      return cb(null, v);
    };
    Mock.prototype.set = function(k, v, cb) {
      k = normalize(k);
      v = normalize(v);
      this.items[enc(k)] = v;
      return cb(null);
    };
    Mock.prototype.getRange = function(_arg, cb) {
      var items, k, k64, k__prefix, max, v, _ref;
      k__prefix = _arg.k__prefix, max = _arg.max;
      if (k__prefix) {
        k__prefix = normalize(k__prefix);
      }
      items = [];
      _ref = this.items;
      for (k64 in _ref) {
        if (!__hasProp.call(_ref, k64)) continue;
        v = _ref[k64];
        if (max && items.length >= max) {
          break;
        }
        k = dec(k64);
        if (k__prefix && !startswith(k, k__prefix)) {
          continue;
        }
        items.push([k, v]);
      }
      return cb(null, items);
    };
    return Mock;
  })();
  module.exports = {
    Mock: Mock,
    MockKV: Mock,
    MockKVR: Mock
  };
}).call(this);
