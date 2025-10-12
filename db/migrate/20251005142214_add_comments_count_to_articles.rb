class AddCommentsCountToArticles < ActiveRecord::Migration[7.0]
  def up
    add_column :articles, :comments_count, :integer, default: 0, null: false
    
    # Update existing articles with their current comment counts using SQL
    execute <<-SQL.squish
      UPDATE articles 
      SET comments_count = (
        SELECT COUNT(*) 
        FROM comments 
        WHERE comments.article_id = articles.id
      )
    SQL
  end

  def down
    remove_column :articles, :comments_count
  end
end