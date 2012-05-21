@Phoney ?= {}

Phoney.MessageList = Backbone.Collection.extend(
  model: Phoney.Message
  parse: (response) ->
    response.rows
  url: 'messages'
)
