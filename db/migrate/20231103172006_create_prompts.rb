class CreatePrompts < ActiveRecord::Migration[6.0]
  def change
    create_table :prompts do |t|
      t.string :text, null: false
      t.timestamps
    end
  end
end
