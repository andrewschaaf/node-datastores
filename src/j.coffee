

{stringify, parse} = require 'keyjson'


class J
  constructor: (@k) ->
  
  get: (k, cb=->) ->
    @k.get stringify(k), cb
  
  set: (k, v, cb=->) ->
    @k.set stringify(k), v, cb
  
  getRange: (constraints, cb=->) ->
    c2 = {}
    c2.k__prefix = stringify constraints.k__prefix    if constraints.k__prefix
    @k.getRange c2, cb


module.exports =
  J: J
  JV: J
  JVR: J
