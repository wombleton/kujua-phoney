@Phoney ?= {}

Phoney.MessageView = Backbone.View.extend(
  events:
    'click .delete-message': 'delete'
    'click .resend-message': 'resend'
  resend: ->
    message = @model.get('value')
    view = $('#messages').data('view')
    view.prepareUpdate(message)
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
    value = _.defaults(@model.get('value'),
      from: 'not supplied'
      sent_to: 'not supplied'
      message: 'not supplied'
    )
    template = _.template("""
      <td>
        <button class="btn btn-mini delete-message">Delete</button>
        <button class="btn btn-mini btn-primary resend-message">Resend</button>
      </td>
      <td><%= from %></td>
      <td><%= sent_to %></td>
      <td><%= message %></td>
    """, value)
    @$el.html(template)
  tagName: 'tr'
)
