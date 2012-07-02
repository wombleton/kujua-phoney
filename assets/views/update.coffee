@Phoney ?= {}

Phoney.UpdateView = Backbone.View.extend(
  load: ->
    message = @model.get('value')
    { message, from, sent_to } = message
    $('[name=message]').val(message)
    $('[name=sent_to]').val(sent_to)
    $('[name=from]').val(from)
  initialize: ->
    @render()
  render: ->
    value = @model.get('value')
    { message, to } = value
    @$el.html("""
      <div class="span2 data">#{to}</div>
      <div class="span4 data">#{message}</div>
    """)
    @
  tagName: 'div'
  className: 'row message'
)

