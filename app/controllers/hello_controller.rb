class HelloController < ApplicationController

  def index
    @teste ="Olha funciona"
    @job=JobManager.find(1)
    if !@job.iniciado
      @job.iniciado=true
      @job.save
      Servidor.uptime
    end
  end

  def backoffice
    @teste ="Olha funciona"
    @job=JobManager.find(1)
    if !@job.iniciado
      @job.iniciado=true
      @job.save
      Servidor.uptime
    end
  end

  def new_server
    @servidor = Servidor.new
  end

  def create_server
    @servidor = Servidor.new(servidor_params)
    @servidor.nome = @servidor.nome.downcase
    @servidor.save
    redirect_to backoffice_path
  end

  def destroy_server
    @servidor=Servidor.find(params[:id])
    @sites=Site.where(servidor_id:params[:id])
    @servidor.destroy
    if @sites.nil?
      @sites.destroy
    end
    redirect_to backoffice_path
  end

  def stopwork
    @job=JobManager.find(1)
    @job.iniciado=false
    @job.save
  end

  def new
    @site=Site.new
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      flash[:info] = "Jogo adicionado com sucesso!"
      redirect_to backoffice_path
    else
      flash[:danger]= @site.errors.full_messages
      redirect_to backoffice_path
    end
  end

  def destroy
    @site = Site.find(params[:id]).destroy
    flash[:success] = "O site '" + @site.nome + "' foi eliminado com sucesso"
    redirect_to backoffice_path
  end

  def edit
    @site = Site.find(params[:id])
  end

  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(site_params)
      redirect_to backoffice_path
    else
      render 'edit'
    end
  end

  def info

    @servidor = Servidor.find_by(nome:params[:id].downcase)
    @servidor.up=2
    @servidor.save
    @sites = Site.all.where(servidor_id:@servidor.id)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json
    end

  end

  def fail
    x = params[:id].split("-")
    @servidor=Site.find(x.first).servidor
    @servidor.up=2
    @servidor.resposta=true
    @servidor.save
    x.each do |y|
      @site=Site.find(y)
      @site.up=1
      @site.resposta=true
      @site.save
    end
    ActionCable.server.broadcast 'notificacoes_channel',
                           content:"teste",
                           id:params[:id],
                           action:"down"
  end

  def ok
    x = params[:id].split("-")
    @servidor=Site.find(x.first).servidor
    @servidor.up=2
    @servidor.resposta=true
    @servidor.save

    x.each do |y|
      @site=Site.find(y)
      @site.up=2
      @site.resposta=true
      @site.save
    end
    ActionCable.server.broadcast 'notificacoes_channel',
                           content:"teste",
                           id:params[:id],
                           action:"up"
  end

  def na
    x = params[:id].split("-")
    @servidor=x.first.servidor
    @servidor.up=2
    @servidor.resposta=true
    @servidor.save
    x.each do |y|
      @site=Site.find(y)
      @site.up=0
      @site.resposta=true
      @site.save
    end
    ActionCable.server.broadcast 'notificacoes_channel',
                           content:"teste",
                           id:params[:id],
                           action:"issues"
  end

  private

  def site_params
    params.require(:site).permit(:nome,:url,:servidor_id)
  end

  def servidor_params
    params.require(:servidor).permit(:nome)
  end

end
