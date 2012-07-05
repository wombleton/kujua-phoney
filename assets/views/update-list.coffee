#= require ../collections/updates
#= require update

Phoney.UpdateListView = Backbone.View.extend(
  initialize: ->
    @collection = new Phoney.UpdateList()
    @collection.bind('reset', @addAll, @)
    @collection.bind('add', @addOne, @)
  update: ->
    @collection.fetch()
  checkMessages: ->
    $.ajax(
      url: '/kujua/_design/kujua-base/_rewrite/add'
      complete: (response) =>
        updates = JSON.parse(response.responseText)
        { callback, payload } = updates
        { messages } = payload or {}
        if messages.length > 0
          timestamp = new Date().getTime()
          docs = _.map(messages, (document) ->
            _.extend(document,
              timestamp: timestamp
              type: 'update'
            )
          )
          $.ajax(
            complete: =>
              @collection.fetch()
              { options, data } = callback
              { host, method, port, path } = options
              _.extend(options,
                data: JSON.stringify(data)
                type: options.method
                url: "http://#{host}:#{port}#{path}"
              )
              $.ajax(options)
            data: JSON.stringify(docs: docs)
            headers:
              'Content-Type': 'application/json'
            type: 'POST'
            url: '../../../_bulk_docs'
          )
    )
  addAll: ->
    @$el.html('')
    @collection.each(@addOne, @)
  addOne: (update) ->
    view = new Phoney.UpdateView(model: update)
    @$el.prepend(view.render().el)
)

