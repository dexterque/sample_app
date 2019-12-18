class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      # 成功 也可以写成 redirect_to user_url(@user)
      flash[:success] = "Successfully created..."
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
