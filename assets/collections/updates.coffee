#= require ../models/update

Phoney.UpdateList = Backbone.Collection.extend(
  model: Phoney.Update
  parse: (response) ->
    response.rows
  url: 'updates'
)

