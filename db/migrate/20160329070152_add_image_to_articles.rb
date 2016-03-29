class AddImageToArticles < ActiveRecord::Migration
  def change
    add_attachment :articles, :image
  end
end
