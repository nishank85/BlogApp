class AddColumnPhotoTo < ActiveRecord::Migration
  def up
  		add_column :posts, :photo_file_name, :string
		add_column :posts, :photo_content_type, :string
		add_column :posts, :photo_file_size, :integer
  end

  def down
  		remove_column :posts, :photo_file_name, :string
		remove_column :posts, :photo_content_type, :string
		remove_column :posts, :photo_file_size, :integer
  end
end
