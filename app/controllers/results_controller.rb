class ResultsController < ApplicationController
  load_and_authorize_resource
  before_filter :get_candidates

  # GET /results
  # GET /results.xml
  def index
    @results = Result.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @results }
    end
  end

  # GET /results/new
  # GET /results/new.xml
  def new
    @result = Result.new

    respond_to do |format|
      unless cookies[:vote] == 'sent' then
        format.html # new.html.erb
        format.xml  { render :xml => @result }
      else
        format.html {
          flash[:alert] = "Sorry, but you already sent your vote"
          redirect_to (results_path)
        }
      end
    end
  end

  # POST /results
  # POST /results.xml
  def create
    @result = Result.new()

    @result.ip_address = request.remote_ip

    unless params[:candidates_ids].nil?
      if params[:candidates_ids].count.eql?(NUMBER_OF_CANDIDATES)
        params[:candidates_ids].each do |candidate_id|
          @result.candidates << Candidate.find(candidate_id)
        end
      end
    end

    respond_to { |format|
      if params[:candidates_ids].nil? ? false : params[:candidates_ids].count.eql?(NUMBER_OF_CANDIDATES)
        if @result.save
          format.html { redirect_to(results_path, :notice => "Thanks for your vote") }
          format.xml { render :xml => @result, :status => :created, :location => @result }
          cookies[:vote] = {:value => 'sent', :expires => 3.days.from_now}
        else
          format.html { render :action => "new" }
          format.xml { render :xml => @result.errors, :status => :unprocessable_entity }
        end
      else
        format.html {
          flash[:alert] = "You should choose " + NUMBER_OF_CANDIDATES.to_s + " candidates"
          redirect_to (new_result_path)
        }
      end }
  end

  # DELETE /results/1
  # DELETE /results/1.xml
  def destroy
    @result = Result.find(params[:id])
    @result.destroy

    respond_to do |format|
      format.html { redirect_to(results_url) }
      format.xml  { head :ok }
    end
  end
end