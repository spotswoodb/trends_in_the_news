class ArticlesController < ApplicationController

    get '/articles' do   
        @articles = Article.require_all
        erb :'articles/index'
    end

    
end