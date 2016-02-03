class UserController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

  helper_method :sort_column, :sort_direction

  def edit
    @user = User.find(params[:id])
    @branches = Branch.all
  end

  def index
    @users = User.order(sort_column + ' ' + sort_direction)
    
    render layout: "single_table", locals: { users: @users  } 
  end

  def new
    @user = User.new
    @branches = Branch.all
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      flash[:notice] = "Usuario creado correctamente"
      redirect_to(:action => 'index')
    else
      @branches = Branch.all
      flash[:notice] = 'error'
      render('new')
    end
  end

  def update

    @branches = Branch.all

    @user = User.find(params[:id])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update_attributes(sign_up_params)
      flash[:notice] = "Usuario editado correctamente"
      redirect_to(:action => 'index')
    else
      flash[:notice] = "Error"
      render('edit')
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
      user = User.find(params[:id]).destroy
      flash[:notice] = "Usuario eliminado correctamente"
      redirect_to(:action => 'index')
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end

    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :code, :branch_id, :user_type, :email, :password, :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:first_name, :last_name, :code, :branch_id, :user_type, :email, :password, :password_confirmation, :current_password)
    end
end