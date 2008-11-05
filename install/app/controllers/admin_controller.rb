class AdminController < ApplicationController
  layout 'admin'

  before_filter :set_mailer_options
  before_filter :authenticate, :except => [:login, :logout]

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

  def set_mailer_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
    true
  end
  private :set_mailer_options

end # of class AdminController
