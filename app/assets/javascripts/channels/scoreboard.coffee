App.scoreboard = App.cable.subscriptions.create "ScoreboardChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#main-scoreboard').replaceWith(data.message)
