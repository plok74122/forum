json.meta do
  json.current_page @article.current_page
  json.total_pages @article.total_pages
  json.per_page @article.limit_value
  json.next_url (@article.last_page?) ? nil : v1_topics_url(:page => @article.next_page)
  json.previous_url (@article.first_page?) ? nil : v1_topics_url(:page => @article.prev_page)
end
json.results do
  json.array!(@article) do |article|
    json.partial! 'article', article: article
  end
end