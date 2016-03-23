class CreateArticleTypes < ActiveRecord::Migration
  def change
    create_table :article_types do |t|
      t.string :article_type
      t.timestamps null: false
    end
  end
end
