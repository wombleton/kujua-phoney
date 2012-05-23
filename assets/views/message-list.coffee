@Phoney ?= {}

Phoney.MessageListView = Backbone.View.extend(
  initialize: ->
    @collection.bind('reset', @addAll, @)
    @collection.bind('add', @addOne, @)
    @collection.fetch()
    $('form').submit(->
      false
    )
  render: ->
    return
  addAll: ->
    @collection.each(@addOne, @)
  addOne: (message) ->
    view = new Phoney.MessageView(model: message)
    @$el.append(view.render())
  send: (data) ->
    $.ajax(
      complete: =>
        @$el.html('')
        @collection.fetch()
        @prepareUpdate(data)
      contentType: 'application/json'
      data: JSON.stringify(data)
      dataType: 'json'
      type: 'POST'
      url: 'messages'
    )
  formatDate: (date) ->
    year = date.getYear() - 100
    month = date.getMonth() + 1
    day = date.getDate()
    hours = date.getHours()
    minutes = date.getMinutes()
    "#{month}-#{day}-#{year} #{hours}:#{minutes}"
  executeUpdate: (response) ->
    { callback } = JSON.parse(response.responseText)
    if callback
      { data, options } = callback
      { headers, host, method, port, path } = options
      opts =
        complete: (response) =>
          @executeUpdate(response)
        data: JSON.stringify(data)
        headers: headers
        type: method
        url: "http://#{host}:#{port}#{path}"
      $.ajax(opts)
  prepareUpdate: (data) ->
    url = $('.export-url').val()
    _.defaults(data,
      message_id: Math.ceil(Math.random() * 100000)
      sent_timestamp: @formatDate(new Date())
    )
    $.ajax(
      complete: (response) =>
        @executeUpdate(response)
      headers:
        'Content-Type': 'application/x-www-form-urlencoded'
      url: url
      type: 'POST'
      data: data
    )
)
