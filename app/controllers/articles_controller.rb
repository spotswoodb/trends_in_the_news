class ArticlesController < ApplicationController

    get '/articles' do
        @articles = Article.all
        erb :'/articles/index'
    end
    
    get '/articles/archives' do
        articles = current_user.articles
        @uniq_articles = articles.uniq {|x| x.id}
        erb :'/articles/archive'
    end

    get '/articles/:id' do
        get_article
        erb :'articles/show'
    end

    def get_article
        @article = Article.find_by(id:params[:id])
    end
        
end