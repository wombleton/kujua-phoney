#= require underscore
#= require jquery
#= require backbone

#= require ns

#= require views/app
#= require views/message-list
#= require collections/messages

$(document).ready(->
  Phoney.application = new Phoney.AppView(
    el: $('#app')
  )
  $('.new-message .send').click(->
    Phoney.application.messages.send(
      from: $('[name=from]').val()
      message: $('[name=message]').val()
      sent_to: $('[name=sent_to]').val()
    )
  )

)
