class CreatePagesTable < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :heading, null: false
      t.text :body, null: false
      t.references :user
      t.timestamps
    end
  end
end
