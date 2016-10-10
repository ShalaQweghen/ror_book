class ChangeColumnNameInPictures < ActiveRecord::Migration[5.0]
  def self.up
  	rename_column :pictures, :image, :picture
  end

  def self.down
  	rename_column :pictures, :picture, :image
  end
end
