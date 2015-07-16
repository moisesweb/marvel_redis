class Api::UsersController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def top5
    fn_user = lambda{ |name|  User.find(name) }
    @top5 = metrics.top_five_login.map(&fn_user).reject {|e| e.blank? }
    respond_with @top5
  end

  def online
    fn_user = ->(name){ User.find(name) }
    @online = metrics.users_online.map(&fn_user).reject {|e| e.blank? }
    respond_with @online
  end

  def login
    status = if params[:id].present? && User.find(params[:id]).present?
      metrics.login_count_for(params[:id])
      metrics.track_online(params[:id])
      :created
    else
      :unprocessable_entity
    end

    puts status
    render json: {}, status: status
  end

  private
    def metrics
      @metrics ||= Metrics.new
    end
end
