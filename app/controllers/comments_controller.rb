class CommentsController < ApplicationController
  before_filter :load_commentable

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment] :user_id => current_user.id)
      #:content => params[:content], :user_id => current_user.id)
    if @comment.save
      redirect_to(:back)
      flash[:success] = "Successfully posted comment!"
    else
      render @commentable
      flash[:failure] = "Comment did not post"
    end
  end

private

  def load_commentable
    @commentable = Picture.find(params[:picture_id])
  end


end
