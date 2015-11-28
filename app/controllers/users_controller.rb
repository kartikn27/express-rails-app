class UsersController < ApplicationController
  
  def new
    @user = User.new    
  end

  def show
    user_id = params[:id]
    @user = User.find(user_id)
  end

  def create
    user_check = User.find_by_email(params[:email])
    if user_check.present?
      flash[:danger] = "User already exists!"
    end
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar))
    Rails.logger.info(@user.errors.inspect) 
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

end
