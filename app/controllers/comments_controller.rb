class CommentsController < ApplicationController

        # CREATE
        get '/comments/new' do
            if current_user
                erb :'comments/new'
            else
                redirect '/login'
            end
        end
    
        post '/comments' do
            @comment = Comment.new(params)
            @comment.user_id = session[:user_id]
            @comment.save
            redirect "/comments/#{@comment.id}"
        end
    
        # READ
        get '/comments' do   
            @comment = Comment.all
            erb :'comments/index'
        end
    
        # SHOW
        get '/comments/:id' do
            get_article
            erb :'comments/show'
        end
    
        # EDIT
        get '/comments/:id/edit' do
            get_article
            redirect_if_not_authorized
            erb :"/comments/edit"
        end
    
        # UPDATE
    
        patch '/comments/:id' do
            get_comment
            redirect_if_not_authorized
            @comment.update(title: params[:title], content: params[:content])
            redirect "/comments/#{@comment.id}"
        end
        
        # DESTROY
    
        delete '/comments/:id' do
            get_comment
            @comment.destroy
            redirect '/comments'
        end

        def get_comment
            @comment = Comment.find_by(id:params[:id])
        end
    
        def redirect_if_not_authorized
            if @comment.user != current_user
                flash[:error] = "You can't make this edit because you don't own this"
                redirect '/comments'
            end
        end

end