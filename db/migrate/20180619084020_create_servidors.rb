class CreateServidors < ActiveRecord::Migration[5.2]
  def change
    create_table :servidors do |t|
      t.string :nome
      t.integer :up, default:1
      t.integer :contador, default:5
      t.boolean :resposta, default:false

      t.timestamps
    end
  end
end
