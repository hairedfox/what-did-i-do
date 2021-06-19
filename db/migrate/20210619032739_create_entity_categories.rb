class CreateEntityCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :entity_categories do |t|
      t.integer :categorizable_id, foreign_key: true, index: true
      t.string :categorizable_type
      t.references :category, foreign_key: true, index: true

      t.timestamps
    end
  end
end
