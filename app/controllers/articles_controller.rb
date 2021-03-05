class ArticlesController < ApplicationController

    get '/articles' do
        @articles = Article.all
        erb :'/articles/index'
    end
    
    get '/articles/:id' do
        get_article
        erb :'articles/show'
    end

    def get_article
        @article = Article.find_by(id:params[:id])
    end
        
end