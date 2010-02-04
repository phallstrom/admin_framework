class Admin::AdminUsersController < AdminController

  PERMISSION = :admin_users
  before_filter :check_permission

  # 
  # 
  def index
    @admin_users = AdminUser.find(:all)
  end

  # 
  # 
  def show
    redirect_to edit_admin_admin_user_path(params[:id])
  end

  # 
  # 
  def new
    @admin_user = AdminUser.new
  end

  # 
  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  # 
  # 
  def create
    @admin_user = AdminUser.new(params[:admin_user])

    if @admin_user.save
      flash[:notice] = "Admin User '#{@admin_user.login}' was successfully created."
      if params[:commit] =~ /continue/
        redirect_to edit_admin_admin_user_path(@admin_user)
      else
        redirect_to admin_admin_users_path
      end
    else
      render :action => "new"
    end
  end

  # 
  # 
  def update
    @admin_user = AdminUser.find(params[:id])

    params[:admin_user][:permissions] = {} if params[:admin_user][:permissions].nil?

    if @admin_user.update_attributes(params[:admin_user])
      flash[:notice] = "Admin User '#{@admin_user.login}' was successfully updated."
      if params[:commit] =~ /continue/
        redirect_to edit_admin_admin_user_path(@admin_user)
      else
        redirect_to admin_admin_users_path
      end
    else
      render :action => "edit"
    end
  end

  # 
  #
  def destroy
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.destroy
      flash[:notice] = "Admin User '#{@admin_user.login}' was destroyed."
    end

    redirect_to(admin_admin_users_path)
  end
end
