class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :job_tittle
      t.string :last_tweet
      t.string :twitter_id

      t.timestamps
    end
  end
end
