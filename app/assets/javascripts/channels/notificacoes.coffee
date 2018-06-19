App.notificacoes = App.cable.subscriptions.create "NotificacoesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # alert(data.content)
    x = data.id.split("-")
    $("#status"+y).removeClass().addClass("status "+data.action) for y in x
