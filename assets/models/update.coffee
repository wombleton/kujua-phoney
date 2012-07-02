@Phoney ?= {}

Phoney.Update = Backbone.Model.extend(
  defaults:
    created_at: new Date().getTime()
    type: 'update'
  getUrl: ->
    { revision } = @get('value')
    "#{@url()}/#{revision}"
)

