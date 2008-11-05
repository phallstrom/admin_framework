class Admin::DashboardController < AdminController

  def index
  end

  def login
    session[:admin_user_id] = nil
    session[:admin_user_token] = nil
    if request.post?
      admin_user = AdminUser.find_by_login_and_password_hash(params[:admin_user][:login], AdminUser.hash_a_password(params[:admin_user][:password]))
      if admin_user.nil?
        flash[:error] = "Unable to authenticate using the provided login and password."
        redirect_to admin_login_path
        return
      end
      session[:admin_user_id] = admin_user.id
      session[:admin_user_token] = AdminUser.make_token(admin_user.login, request)
      flash[:info] = "Successfully logged in as '#{admin_user.login}'."
      redirect_to admin_path
    end

    @admin_user = AdminUser.new
    return
  end

  def logout
    session[:admin_user_id] = nil
    session[:admin_user_token] = nil
  end
end
