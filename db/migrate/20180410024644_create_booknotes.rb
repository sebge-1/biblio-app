class CreateBooknotes < ActiveRecord::Migration
  def change
    create_table :booknotes do |t|
      t.string :summary
      t.string :quotes
      t.string :research
      t.integer :book_id
    end
  end
end
