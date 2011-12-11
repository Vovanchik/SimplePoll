class ApplicationController < ActionController::Base
  protect_from_forgery

  NUMBER_OF_CANDIDATES = 5


  before_filter :get_results

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def get_candidates
    @candidates = Candidate.all
  end

  def get_results
    @results = Result.all
  end

  #=begin
  rescue_from CanCan::AccessDenied do |exception|
      redirect_to results_url
  end
  #=end
end