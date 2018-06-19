class Servidor < ApplicationRecord

  has_many :sites

  def self.uptime
    UptimeWorker.perform_async()
  end

end
