class ApplicationController < ActionController::Base
  include ActionView::Helpers::DateHelper

  before_action :track_visits
  before_action :set_greeting

  private

  def track_visits
    session[:total_visits] ||= 0
    session[:page_visits] ||= {}
    session[:last_visit] ||= Time.current

    session[:total_visits] += 1
    session[:page_visits][request.path] ||= 0
    session[:page_visits][request.path] += 1

    @time_since_last_visit = time_ago_in_words(session[:last_visit])
    session[:last_visit] = Time.current
  end

  def set_greeting
    current_hour = Time.current.hour
    @greeting = if current_hour.between?(5, 11)
                  "Good morning!"
    elsif current_hour.between?(12, 16)
                  "Good afternoon!"
    elsif current_hour.between?(17, 20)
                  "Good evening!"
    else
                  "Good night!"
    end
  end
end
