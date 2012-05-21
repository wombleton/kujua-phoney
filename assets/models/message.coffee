@Phoney ?= {}

Phoney.Message = Backbone.Model.extend(
  defaults:
    created_at: new Date().getTime()
    type: 'message'
  getUrl: ->
    { revision } = @get('value')
    "#{@url()}/#{revision}"
)
