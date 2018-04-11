class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create show)
  before_action :correct_user, only: %i(edit update)
  before_action :verify_admin!, only: :destroy
  before_action :find_user, except: %i(index new create)

  def index
    @users = User.order("created_at asc")
      .paginate page: params[:page], per_page: 20
  end

  def new
    @user = User.new
  end

  def create
    user = User.new user_params

    if user.save
      user.send_activation_email
      flash[:info] = t "check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    @microposts = @user.microposts.paginate page: params[:page]
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t"update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_deleted"
      redirect_to users_url
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = t"no_user"
    redirect_to root_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def verify_admin!
    redirect_to root_url unless current_user.admin?
  end
end
