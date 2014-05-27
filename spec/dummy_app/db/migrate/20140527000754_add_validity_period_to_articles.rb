class AddValidityPeriodToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :valid_from, :datetime
    add_index :articles, :valid_from
    add_column :articles, :valid_to, :datetime
    add_index :articles, :valid_to
  end
end
