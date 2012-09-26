class CommentsController < ApplicationController
  before_filter :load_commentable

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    if @comment.save
      redirect_to(:back)
      flash[:success] = "Successfully posted comment!"
    else
      render @commentable
      flash[:failure] = "Comment did not post"
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    flash[:alert] = "Comment successfully deleted"
    redirect_to(:back)
  end

private

  def load_commentable
    if params[:picture_id]
      @commentable = Picture.find(params[:picture_id])
    elsif params[:event_id]
      @commentable = Event.find(params[:event_id])
    end
  end

end
