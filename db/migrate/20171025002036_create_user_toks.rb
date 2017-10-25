class CreateUserToks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_toks do |t|
      t.string :token
      t.string :device_token
      t.integer :object_id

      t.timestamps
    end
  end
end
