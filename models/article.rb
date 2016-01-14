class Article
  @@articles = {}
  @@next_id = 1

  def self.all
    @@articles.values
  end

  def self.find! id
    @@articles.fetch id.to_i
  end

  def self.find_by_title title
    @@articles.detect { |_, a| a.title == title }
  end

  def self.create args
    return if find_by_title(args[:title])

    article = Article.new(args.merge(id: @@next_id += 1))
    @@articles[article.id] = article
    article
  end

  attr_reader :id, :title

  def initialize args
    args.each { |k,v| instance_variable_set "@#{k}", v }
  end

  def save!
    @saved = true
  end

  def saved?
    @saved
  end
end
