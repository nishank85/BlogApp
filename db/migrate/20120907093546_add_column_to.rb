class AddColumnTo < ActiveRecord::Migration
	def change
		add_column :comments, :commentable_type, :string
		rename_column :comments, :post_id, :commentable_id
	end
end