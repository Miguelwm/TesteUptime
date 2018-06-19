class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.string :nome
      t.string :url
      t.integer :up, default:0
      t.integer :contador, default:0
      t.boolean :resposta, default:false
      t.belongs_to :servidor, index: true

      t.timestamps
    end
  end
end
