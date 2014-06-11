
class App.Requests
  data: (url, cb) ->
    @buildRequest url, cb

  allSpecs: (url) ->
    @buildRequest url

  buildRequest: (url, cb) ->
    $.ajax
      url: 'proxy'
      data:
        url: encodeURI(url)
      type: 'GET'
      dataType: "json"
      success: (data) ->
        cb.call(this, data)
      error: (err,xhr,data) ->
        console.log err, xhr, data
        console.log "error"





