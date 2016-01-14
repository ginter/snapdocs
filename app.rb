require 'rss'
require_relative 'models/article'

get '/' do
  @articles = Article.all
  erb :'index.html'
end

post '/articles/:id/save' do
  article = Article.find!(params[:id])
  article.save!

  redirect to('/')
end

Thread.new do
  loop do
    p 'LOADING ARTICLES'
    rss = RSS::Parser.parse('https://news.ycombinator.com/rss')
    rss.items.each { |i| Article.create title: i.title, link: i.link }
    sleep 300
  end
end
