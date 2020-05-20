class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username

      t.timestamps
    end

    add_index :username, :email, unique: true
  end
end
