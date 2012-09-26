class EventsController < ApplicationController
  before_filter :signed_in_user, only: [:uploaders, :create, :destroy]
  before_filter :host_user, only: :destroy

  def index
    @events = Event.paginate(page: params[:page])
  end

  def uploaders
    @event = Event.find(params[:id])
    @users = User.paginate(page: params[:page])
  end

  def show
    @event = Event.find(params[:id])
    @events = Picture.paginate(page: params[:page])

    @commentable = @event
    @comments = @commentable.comments
    @comment = Comment.new(:user_id => current_user.id)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events_hosted.build(params[:event])
    if @event.save
      flash[:success] = "Event created!"
      @event.host_id = current_user.id
      redirect_to @event
    else
      redirect_to(:back)
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to(:back)
  end

  private

    def host_user
      @event = Event.find(params[:id])
      redirect_to root_path unless current_user.id == @event.host_id
    end

end
