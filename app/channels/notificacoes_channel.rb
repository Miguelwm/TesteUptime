class NotificacoesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notificacoes_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
