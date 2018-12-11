class AddSummaryToBooks < ActiveRecord::Migration
  def change
    add_column :books, :summary, :string
  end
end
