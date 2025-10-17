class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :name # shorter sequence of chars
      t.text :description # longer sequence of chars
      t.timestamps
    end
  end
end
