class TokAccessCreateUsers < ActiveRecord::Migration[5.1]
  def change

    create_table :users do |t|
      t.string :password_digest, null: false, default: ""

      
        t.string :email
      
        t.string :nickname
      
        t.text :img_path
      
    end
  end

end
