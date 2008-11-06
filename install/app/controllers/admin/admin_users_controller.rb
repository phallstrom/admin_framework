class Admin::AdminUsersController < AdminController

  PERMISSION = :admin_users
  before_filter :check_permission

  # 
  # 
  def index
    @admin_users = AdminUser.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_users }
    end
  end

  # 
  # 
  def show
    @admin_user = AdminUser.find(params[:id])

    respond_to do |format|
      format.html { render :action => 'edit' }
      format.xml  { render :xml => @admin_user }
    end
  end

  # 
  # 
  def new
    @admin_user = AdminUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_user }
    end
  end

  # 
  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  # 
  # 
  def create
    @admin_user = AdminUser.new(params[:admin_user])

    respond_to do |format|
      if @admin_user.save
        flash[:notice] = "Admin User '#{@admin_user.login}' was successfully created."
        format.html { redirect_to(admin_admin_users_path) }
        format.xml  { render :xml => @admin_user, :status => :created, :location => @admin_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # 
  # 
  def update
    @admin_user = AdminUser.find(params[:id])

    params[:admin_user][:permissions] = {} if params[:admin_user][:permissions].nil?

    respond_to do |format|
      if @admin_user.update_attributes(params[:admin_user])
        flash[:notice] = "Admin User '#{@admin_user.login}' was successfully updated."
        format.html { redirect_to(admin_admin_users_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # 
  #
  def destroy
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.destroy
      flash[:notice] = "Admin User '#{@admin_user.login}' was destroyed."
    end

    respond_to do |format|
      format.html { redirect_to(admin_admin_users_path) }
      format.xml  { head :ok }
    end
  end
end
