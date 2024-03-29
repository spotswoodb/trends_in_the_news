class CommentsController < ApplicationController

        # READ
        
        get '/articles/:article_id/comments' do 
            get_article  
            article = Article.find_by(id:params[:article_id])
            @comments = article.comments
            erb :'comments/index'
        end
        
        # CREATE
        get '/articles/:article_id/comments/new' do
            if current_user
                get_article
                erb :'comments/new'
            else
                redirect '/login'
            end
        end
    
        post '/articles/:article_id/comments' do
            article = Article.find_by(id:params[:article_id])
            @comment = article.comments.build(params)
            @comment.user_id = session[:user_id]
            @comment.save
            redirect "/articles/#{article.id}/comments/#{@comment.id}"
        end
    
        # SHOW
        get '/articles/:article_id/comments/:id' do
            get_article
            get_comment
            erb :'comments/show'
        end
    
        # EDIT
        get '/articles/:article_id/comments/:id/edit' do
            get_comment
            redirect_if_not_authorized
            erb :'comments/edit'
        end
    
        # UPDATE
    
        patch '/articles/:article_id/comments/:id' do
            get_article
            get_comment
            redirect_if_not_authorized
            @comment.update(title: params[:title], content: params[:content])
            redirect "/articles/#{@article.id}/comments/#{@comment.id}"
        end
        

        # DESTROY
    
        delete '/articles/:article_id/comments/:id' do
            get_article
            get_comment
            @comment.destroy
            redirect "/articles/#{@article.id}/comments"
        end

    private

        def get_article
            @article = Article.find_by(id:params[:article_id])
        end    
        
        def get_comment
            @comment = Comment.find_by(id:params[:id])
        end


        def redirect_if_not_authorized
            get_article
            if @comment.user != current_user
                flash[:error] = "You can't make this edit because you don't own this"
                redirect "/articles/#{@article.id}/comments"
            end
        end

end