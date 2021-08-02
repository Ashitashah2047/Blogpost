class CommentsController < ApplicationController

    def create

        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params)

        if @comment.save
            UserMailer.signup_email(@post.id).deliver_later
            redirect_to post_path(@post)
        end

    end

    def destroy
        
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:id])
        @comment.destroy

        redirect_to @post

    end

    private

    def comment_params
        params.require(:comment).permit(:comment, :user_id)
    end
    
end
