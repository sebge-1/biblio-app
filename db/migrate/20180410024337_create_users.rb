class CreateUsers < ActiveRecord::Migration
  def change
    create_table_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
  end
end
