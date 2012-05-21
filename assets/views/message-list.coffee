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
        @updateKujua(data)
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
  updateKujua: (data) ->
    url = "#{$('.export-url').val()}/_design/kujua-export/_rewrite/add"
    _.defaults(data,
      message_id: Math.ceil(Math.random() * 100000)
      sent_timestamp: @formatDate(new Date())
    )
    $.ajax(
      headers:
        'Content-Type': 'application/x-www-form-urlencoded'
      url: url
      type: 'POST'
      data: data
    )
)
