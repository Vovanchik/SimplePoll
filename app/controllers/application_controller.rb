class ApplicationController < ActionController::Base
  protect_from_forgery

  NUMBER_OF_CANDIDATES = 5

  private

  def get_candidates
    @candidates = Candidate.all
  end

end
