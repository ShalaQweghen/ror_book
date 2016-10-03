class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
    	t.references :friender, references: :user
    	t.references :friend, references: :user
    	t.integer :approve, default: 0

      t.timestamps
    end
  end
end
