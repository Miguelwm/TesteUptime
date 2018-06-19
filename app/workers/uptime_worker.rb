class UptimeWorker
  include Sidekiq::Worker

  def perform(finish = false)
    puts "**********************"
    puts "Inicio do Job"
    puts "**********************"
    if JobManager.find(1).iniciado
      sleep 60
    end

    Servidor.all.each do |s|
        if s.resposta
          s.resposta=false
          s.contador=0
          s.save
        else
          if s.contador>5
            s.up=1
            s.save
          else
            s.contador=s.contador+1
            s.up=0
            s.save
          end
        end
    end

    Site.all.each do |s|
        if s.resposta
          s.resposta=false
          s.contador=0
          s.save
        else
          if s.contador>5
            s.up=1
            s.save
          else
            s.contador=s.contador+1
            s.up=0
            s.save
          end
        end
    end

    puts "**********************"
    puts "fim do job"
    puts "**********************"
    if JobManager.find(1).iniciado
      Servidor.uptime
    end

  end
end
