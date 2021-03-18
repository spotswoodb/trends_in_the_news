require 'dotenv'
Dotenv.load

response = RestClient.get("http://newsapi.org/v2/top-headlines?country=us&apiKey=#{ENV["NEWS_KEY"]}")

news_array = JSON.parse(response)["articles"]

news_array.each do |article|
    Article.create(:title => article["title"], :date =>  article["publishedAt"], :content =>  article["content"])
end


