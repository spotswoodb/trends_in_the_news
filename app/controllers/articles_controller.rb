class ArticlesController < ApplicationController

    get '/articles' do   
        @articles = Article.all
        erb :'articles/index'
    end

    get '/articles/new' do
        erb :'articles/new'
    end

    get '/articles/:id' do
        get_article
        erb :'articles/show'
    end

    post '/articles' do
        @article = Article.new(params)
        @article.user_id = session[:user_id]
        @article.save
        redirect "/articles/#{@article.id}"
    end

    get '/articles/:id/edit' do
        get_article
        redirect_if_not_authorized
        erb :"/articles/edit"
    end

    patch '/articles/:id' do
        get_article
        redirect_if_not_authorized
        @article.update(title: params[:title], content: params[:content])
        redirect "/articles/#{@article.id}"
    end

    delete '/articles/:id' do
        get_article
        @article.destroy
        redirect '/articles'
    end


    def get_article
        @article = Article.find_by(id:params[:id])
    end

    def redirect_if_not_authorized
        if @article.user != current_user
            flash[:error] = "You can't make this edit because you don't own this"
            redirect '/articles'
        end
    end
        
end