#= require message-list
#= require update-list

Phoney.AppView = Backbone.View.extend(
  initialize: ->
    @render()
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
