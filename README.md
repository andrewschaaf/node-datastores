
# Stuff
<pre>
{
  JVR,
  MockKVR
} = require 'datastores'
</pre>


# Abstractions

## KV

* <code>k</code> is an arbitrary Buffer. If you pass a string, it will get UTF-8-encoded.
* <code>v</code> is an arbitrary Buffer. If you pass a string, it will get UTF-8-encoded.

<pre>
.set k, v,  (e) ->

.get k,     (e, v) ->p
</pre>

## KVR

KV plus:

<pre>
.getRange {k__prefix:"foo/", max:50}, (e, items) ->
  for [k, v] in items
    ...

# TODO: implement this:
.getRangeEmitter {...}, (e, itemEmitter) ->
  itemEmitter.on 'item', (k, v) ->
  itemEmitter.on 'end', () ->
  # itemEmitter.pause
  # itemEmitter.resume
  # itemEmitter.destroy
</pre>


## {JV, JVR}

A wrapper around a {KV, KVR} store, keyjson-{en,de}oding the keys.
<pre>
jv = new JV kv
jv.set [WIKIMEDIA, 'enwiki', articleId, revId], data, (e) ->
jv.getRange k__prefix:[WIKIMEDIA, 'enwiki', articleId], (e, items) ->
</pre>


## SQL
<pre>
TODO
</pre>


# Engines

### MockKVR

* in-RAM
* O(total-number-of-items) <code>getRange</code>s so far

<pre>
kvr = new MockKVR
</pre>
