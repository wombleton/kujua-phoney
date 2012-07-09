#= require ../models/update

Phoney.UpdateList = Backbone.Collection.extend(
  model: Phoney.Update
  parse: (response) ->
    _.map(response.rows, (row) ->
      row.value
    )
  url: 'updates'
  exists: (reported_date, message) ->
    @find((update) ->
      update.get('timestamp') is reported_date and update.get('sent_to') is message.to and update.get('message') is message.message
    )
)
