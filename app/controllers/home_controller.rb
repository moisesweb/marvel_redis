class HomeController < ApplicationController
  def index
    metrics = Metrics.new
    fn_user = ->(name){ User.find(name) }
    @top5   = metrics.top_five_login.map(&fn_user).reject {|e| e.blank? }
    @online = metrics.users_online.map(&fn_user).reject {|e| e.blank? }

    respond_to do |format|
      format.html
      format.js {}
    end

  end

  def login
    metrics = Metrics.new
    if params[:name].present?
      metrics.login_count_for(params[:name])
      metrics.track_online(params[:name])
    end
    render :nothing => true
  end

  def fight
  end
end
