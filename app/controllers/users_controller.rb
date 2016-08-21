class UsersController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update]
#右上の３つのメソッドに実行するときに、先に、set_paramsを実行する
  before_action :correct_user, only: [:edit, :update]
#エディット、アップデートの前に、correct_userを実行する
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ツイッターもどきにようこそ！"
      redirect_to @user
    else
     render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "更新しました"
      redirect_to @user
    else
     render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile)
  end
  
  def set_params
    @user = User.find(params[:id])
  end
  
  def correct_user
    redirect_to root_path if @user != current_user
#正しいユーザーではない場合、リダイレクト（最初の画面に戻す）
  end
end