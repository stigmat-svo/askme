class AddProfilecolorToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profilecolor, :string, default: "#005a55"
  end
end
