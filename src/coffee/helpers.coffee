

#
# Helper Functions
#


String::toObject = ->
  o = {}
  @.replace(
    new RegExp("([^?=&]+)(=([^&]*))?", "g"), ($0, $1, $2, $3) ->
      o[$1] = $3
  )
  return o

delay = (time, callback) ->
  setTimeout ->
    callback.call()
  , time
