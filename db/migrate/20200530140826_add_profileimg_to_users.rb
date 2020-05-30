class AddProfileimgToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profileimg, :string
  end
end
