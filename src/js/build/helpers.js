var delay;

String.prototype.toObject = function() {
  var o;
  o = {};
  this.replace(new RegExp("([^?=&]+)(=([^&]*))?", "g"), function($0, $1, $2, $3) {
    return o[$1] = $3;
  });
  return o;
};

delay = function(time, callback) {
  return setTimeout(function() {
    return callback.call();
  }, time);
};
