class AddUidAndProviderToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :gender, :string
    add_column :users, :image, :string
    add_column :users, :details, :text
  end
end
