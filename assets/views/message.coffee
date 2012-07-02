@Phoney ?= {}

Phoney.MessageView = Backbone.View.extend(
  events:
    'click .delete-message': 'delete'
    'click .load-message': 'load'
  load: ->
    message = @model.get('value')
    { message, from, sent_to } = message
    $('[name=message]').val(message)
    $('[name=sent_to]').val(sent_to)
    $('[name=from]').val(from)
  delete: ->
    $.ajax(
      complete: =>
        @remove()
      url: @model.getUrl()
      type: 'DELETE'
    )
  initialize: ->
    @render()
  render: ->
    value = @model.get('value')
    { message } = value
    @$el.html("""
      <div class="span5 data">#{message}</div>
      <div class="span1">
        <button class="btn btn-mini btn-info load-message">
          <i class="icon-edit"></i>
        </button>
        <button class="btn btn-mini delete-message">
          <i class="icon-trash"></i>
        </button>
      </div>
    """)
    @
  tagName: 'div'
  className: 'row message'
)
