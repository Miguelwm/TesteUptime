App.notificacoes = App.cable.subscriptions.create "NotificacoesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # alert(data.content)

    if data.action is "response"
      x = data.id.split("-")
      $("#status"+y).removeClass().addClass("status "+data.sub_action) for y in x
      console.log(data.id+"\n\naction: "+data.action+"\nsub_action:"+data.sub_action)
    if data.action is "response_server"
      $("#statusserver"+data.id).removeClass().addClass("status server "+data.sub_action)
      console.log(data.id+"\n\naction: "+data.action+"\nsub_action:"+data.sub_action)
    if data.action is "uptime_site"
      x = data.id.split("-")
      $("#status"+y).removeClass().addClass("status "+data.sub_action) for y in x
      console.log(data.id+"\n\naction: "+data.action+"\nsub_action:"+data.sub_action)
    if data.action is "uptime_server"
      x = data.id.split("-")
      $("#statusserver"+y).removeClass().addClass("status server "+data.sub_action) for y in x
      console.log(data.id+"\n\naction: "+data.action+"\nsub_action:"+data.sub_action)
