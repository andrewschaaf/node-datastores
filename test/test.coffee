
assert = require 'assert'
{JVR, MockKVR} = require '../lib/datastores'

normalize = (k) ->
  if k instanceof Buffer
    k
  else if typeof k == 'string'
    new Buffer k
  else
    throw new Error "Expected Buffer or string"

BINARY = new Buffer [0, 0, 255, 254, 65, 0, 0]
INTERNATIONALIZATION = JSON.parse '"I\u00f1t\u00ebrn\u00e2ti\u00f4n\u00e0liz\u00e6ti\u00f8n"'

kv = kvr = new MockKVR
jv = jvr = new JVR kvr

eq = (buf1, buf2) ->
  buf1 = normalize buf1
  buf2 = normalize buf2
  assert.equal buf1.toString('base64'), buf2.toString('base64')


main = () ->
  
  kv.set BINARY, "v1", (e) ->
    kv.get BINARY, (e, v) ->
      eq v, "v1"
      
      jv.set [1, 2], "j12", (e) ->
        jv.get [1, 2], (e, v) ->
          eq v, "j12"
          
          kv.set "k1", "v1", (e) ->
            kv.set "k2", "v2", (e) ->
              kv.set "k2a", "v2a", (e) ->
                kv.set "k2b", "v2b", (e) ->
                  kv.set "k3", "v2b", (e) ->
                    kv.getRange k__prefix:"k2", (e, items) ->
                      assert.equal items.length, 3
                      console.log 'OK'

module.exports =
  main: main
