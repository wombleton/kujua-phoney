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
      url: '/kujua/_design/kujua-base/_rewrite/add?v=' + new Date().getTime()
      complete: (response) =>
        updates = JSON.parse(response.responseText)?.callback?.data?.docs or []

        if updates.length > 0
          docs = _.reduce(updates, (memo, update) ->
            { reported_date, tasks } = update
            messages = _.flatten(_.pluck(tasks, 'messages'))
            _.each(messages, (message) ->
              unless @collection.exists(reported_date, message)
                memo.push(
                  message: message.message
                  sent_to: message.to
                  timestamp: reported_date
                  type: 'update'
                )
            , @)
            memo
          , [], @)
          $.ajax(
            complete: =>
              @collection.fetch()
            data: JSON.stringify(docs: docs)
            headers:
              'Content-Type': 'application/json'
            type: 'POST'
            url: '/kujua-phoney/_bulk_docs'
          )
    )
  addAll: ->
    @$el.html('')
    @existing = []
    @collection.each(@addOne, @)
  addOne: (update) ->
    key = "#{update.get('timestamp')}-#{update.get('message')}"
    unless _.include(@existing, key)
      @existing.push(key)
      view = new Phoney.UpdateView(model: update)
      @$el.prepend(view.render().el)
)

