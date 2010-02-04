class AdminController < ApplicationController
  layout 'admin'

  before_filter :authenticate, :except => [:login]
  before_filter :browser_check

  def authenticate
    @the_admin_user = AdminUser.find(session[:admin_user_id]) rescue nil
    if @the_admin_user.nil? || session[:admin_user_token] != AdminUser.make_token(@the_admin_user.login, request)
      flash[:warning] = "You must login to access this section. Please login below."
      redirect_to admin_login_path
      return
    end
    !@the_admin_user.nil?
  end
  private :authenticate

  def check_permission
    if !@the_admin_user.is_superuser? && @the_admin_user.permissions[self.class::PERMISSION].nil?
      flash[:error] = "You do not have access to '#{self.class::PERMISSION}'."
      redirect_to admin_path
    end
    true
  end
  private :check_permission

  def browser_check
    flash[:warning] = "You are using a very old browser. You are strongly encouraged to upgrade." if request.user_agent =~ /MSIE 6/i
  end
  private :browser_check

end # of class AdminController

def check_permission(permission = nil)
  permission = self.class::PERMISSION if permission.nil?
  if !@the_admin_user.has_access_to?(permission)
    flash[:error] = "You do not have access to '#{permission.inspect}'."
    redirect_to admin_path
    return false
  end
  return true
end
private :check_permission
