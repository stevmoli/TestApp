class RemoveUserFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :user
  end

  def down
    add_column :posts, :user, :string
  end
end
