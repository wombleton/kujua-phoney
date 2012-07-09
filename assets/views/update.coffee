@Phoney ?= {}

Phoney.UpdateView = Backbone.View.extend(
  initialize: ->
    @render()
  render: ->
    ts = new Date(@model.get('timestamp'))
    @$el.html("""
      <div class="span2 data">
        <div class="label">#{@model.get('sent_to')}</div>
        #{ts.getFullYear()}-#{ts.getMonth() + 1}-#{ts.getDate()} #{ts.getHours()}:#{ts.getMinutes()}
      </div>
      <div class="span4 data">#{@model.get('message')}</div>
    """)
    @
  tagName: 'div'
  className: 'row message'
)
