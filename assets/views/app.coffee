#= require message-list
#= require update-list

Phoney.AppView = Backbone.View.extend(
  initialize: ->
    @phoneySince = 0
    @phoneyChangeListener()
    @kujuaSince = 0
    @kujuaChangeListener()
    @render()
  onKujuaChange: ->
    @updates.checkMessages()
  kujuaChangeListener: ->
    $.ajax(
      complete: (response) =>
        result = JSON.parse(response.responseText)
        @kujuaSince = result.last_seq
        @kujuaChangeListener()
        @onKujuaChange() if result.results.length > 0
      url: "/kujua/_changes?feed=longpoll&since=#{@kujuaSince}"
    )
  onPhoneyChange: ->
    @messages.update()
    @updates.update()
  phoneyChangeListener: ->
    $.ajax(
      complete: (response) =>
        result = JSON.parse(response.responseText)
        @phoneySince = result.last_seq
        @phoneyChangeListener()
        @onPhoneyChange() if result?.results?.length > 0
      url: "/kujua-phoney/_changes?feed=longpoll&since=#{@phoneySince}"
    )
  render: ->
    @$el.html("""
      <div class="container">
        <div class="row">
          <div class="span6">
            <h2>Sent</h2>
            <div id="messages"></div>
          </div>
          <div class="span6">
            <h2>Received</h2>
            <div id="updates"></div>
          </div>
        </div>
      </div>
    """)
    @messages = new Phoney.MessageListView()
    @$el.find('#messages').html(@messages.render().el)
    @updates = new Phoney.UpdateListView()
    @$el.find('#updates').html(@updates.render().el)
    @
)
