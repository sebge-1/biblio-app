class CreateBooknotes < ActiveRecord::Migration
  def change
    create_table :booknotes do |t|
      t.string :summary
      t.string :main_premise
      t.string :quotes
      t.string :follow_up
      t.integer :book_id
    end
  end
end
