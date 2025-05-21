class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :set_greeting, :track_visits, :track_last_seen

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def set_greeting
    hour = Time.current.hour
    @greeting =
      case hour
      when 5..11 then 'Good morning!'
      when 12..16 then 'Good afternoon!'
      when 17..20 then 'Good evening!'
      else 'Good night!'
      end
  end

  def track_visits
    session[:total_visits] ||= 0
    session[:total_visits] += 1

    session[:page_visits] ||= {}
    path = request.path
    session[:page_visits][path] ||= 0
    session[:page_visits][path] += 1
  end

  def track_last_seen
    return unless current_user

    @last_seen = current_user.last_visited
    current_user.update(last_visited: Time.current)
  end
end
