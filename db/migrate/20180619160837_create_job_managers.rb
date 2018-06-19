class CreateJobManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :job_managers do |t|
      t.boolean :iniciado, default:false

      t.timestamps
    end
  end
end
