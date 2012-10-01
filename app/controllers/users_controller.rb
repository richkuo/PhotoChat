class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
   
  def index
    @users = User.paginate(page: params[:page])
  end
   
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @events = @user.events_hosted.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      if params[:remember_me]
        sign_in @user
      else
        sign_in_non_remember @user
      end
      flash[:success] = "Welcome #{@user.name}!"
      redirect_to root_path
    else
      render 'new'
    end
  end
   
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile successfully updated!"
      sign_in @user
      redirect_to(:back)
    else
      render 'edit'
    end
  end

  def destroy
    if User.find(params[:id]).admin?
      flash[:error] = "Cannot delete yourself."
    else
      User.find(params[:id]).destroy
      flash[:success] = "User successfully deleted."
    end
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
   end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def pictures
    @user = User.find(params[:id])
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
