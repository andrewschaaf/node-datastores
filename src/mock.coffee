

normalize = (k) -> if k instanceof Buffer then k else new Buffer k
enc = (k) -> k.toString 'base64'
dec = (b64) -> new Buffer b64, 'base64'
startswith = (buf1, buf2) ->
  return false if buf2.length > buf1.length
  for i in [0...buf2.length]
    return false if buf1[i] != buf2[i]
  true


class Mock
  constructor: () ->
    @items = {}
  
  get: (k, cb) ->
    k = normalize k
    v = @items[enc k] or null
    cb null, v
  
  set: (k, v, cb) ->
    k = normalize k
    v = normalize v
    @items[enc k] = v
    cb null
  
  getRange: ({k__prefix, max}, cb) ->
    k__prefix = normalize k__prefix if k__prefix
    items = []
    for own k64, v of @items
      break     if max and items.length >= max
      k = dec(k64)
      continue  if k__prefix and not startswith(k, k__prefix)
      items.push [k, v]
    cb null, items


module.exports =
  Mock: Mock
  MockKV: Mock
  MockKVR: Mock