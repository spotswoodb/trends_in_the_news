class ArticlesController < ApplicationController


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