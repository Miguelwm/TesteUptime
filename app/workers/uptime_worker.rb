class UptimeWorker
  include Sidekiq::Worker

  def perform(finish = false)
    puts "**********************"
    puts "Inicio do Job"
    puts "**********************"
    if JobManager.find(1).iniciado

    end

    ok_server=""
    fail_server=""
    na_server=""

    Servidor.all.each do |s|
        if s.resposta
          s.resposta=false
          s.contador=0
          s.save
          ok_server=ok_server + s.id.to_s + "-"
        else
          if s.contador>=5
            s.up=1
            s.save
            fail_server=fail_server + s.id.to_s + "-"
          else
            s.contador=s.contador+1
            s.up=0
            s.save
            na_server=na_server + s.id.to_s + "-"
          end
        end
    end
if fail_server!=""
    ActionCable.server.broadcast 'notificacoes_channel',
                          content:"teste",
                          id:fail_server,
                          action:"uptime_server",
                          sub_action:"down"
end
if na_server!=""
    ActionCable.server.broadcast 'notificacoes_channel',
                           content:"teste",
                           id:na_server,
                           action:"uptime_server",
                           sub_action:"issues"
end

  ok_site=""
  fail_site=""
  na_site=""

    Site.all.each do |s|
        if s.resposta
          s.resposta=false
          s.contador=0
          s.save
          ok_site=ok_site + s.id.to_s + "-"
        else
          if s.contador>=5
            s.up=1
            s.save
            fail_site=fail_site + s.id.to_s + "-"
          else
            s.contador=s.contador+1
            s.up=0
            s.save
            na_site=na_site + s.id.to_s + "-"
          end
        end
    end
if fail_site!=""
    ActionCable.server.broadcast 'notificacoes_channel',
                           content:"teste",
                           id:fail_site,
                           action:"uptime_site",
                           sub_action:"down"
end
if na_site!=""
    ActionCable.server.broadcast 'notificacoes_channel',
                          content:"teste",
                          id:na_site,
                          action:"uptime_site",
                          sub_action:"issues"
end

  puts "******************DEBUG************************"
  puts "ok_server: "+ok_server.to_s
  puts "fail_server: "+fail_server.to_s
  puts "na_server: "+na_server.to_s
  puts "ok_site: "+ok_site.to_s
  puts "fail_site: "+fail_site.to_s
  puts "na_site: "+na_site.to_s
  puts "******************DEBUG************************"

    puts "**********************"
    puts "fim do job"
    puts "**********************"
    if JobManager.find(1).iniciado
      sleep 30
      Servidor.uptime
    end

  end
end
