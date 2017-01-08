class AddFriendIdToFriends < ActiveRecord::Migration[5.0]
  def change
    add_column :friends, :friend_id, :string
  end
end
