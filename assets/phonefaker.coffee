#= require underscore
#= require jquery
#= require backbone

#= require models/message
#= require views/message
#= require views/message-list
#= require collections/messages

$(document).ready(->
  messages = new Phoney.MessageListView(
    collection: new Phoney.MessageList()
    el: $('#messages')
  )
  $('.new-message .send').click(->
    messages.send(
      from: $('[name=from]').val()
      message: $('[name=message]').val()
      sent_to: $('[name=sent_to]').val()
    )
  )

  $('#messages').data('view', messages)
)
