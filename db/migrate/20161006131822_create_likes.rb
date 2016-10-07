class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
    	t.references :user
    	t.references :likable, polymorphic: true, index: true
    	t.integer :liked, default: 1

      t.timestamps
    end
  end
end
