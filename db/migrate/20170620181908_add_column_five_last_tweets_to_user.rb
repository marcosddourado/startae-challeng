class AddColumnFiveLastTweetsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :five_last_tweets, :string
  end
end
