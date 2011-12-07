class ResultsController < ApplicationController
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

  # GET /results/1
  # GET /results/1.xml
  def show
    @result = Result.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @result }
    end
  end

  # GET /results/new
  # GET /results/new.xml
  def new
    @result = Result.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @result }
    end
  end

  # GET /results/1/edit
  #def edit
  #  @result = Result.find(params[:id])
  #end

  # POST /results
  # POST /results.xml
  def create
    @result = Result.new()

    @result.ip_address = request.remote_ip

    params[:candidates_ids].each do |candidate_id|
      @result.candidates << Candidate.find(candidate_id) if params[:candidates_ids].count.eql?(NUMBER_OF_CANDIDATES)
    end

    puts params[:candidates_ids].count.eql?(NUMBER_OF_CANDIDATES)

    respond_to do |format|
      if params[:candidates_ids].count.eql?(NUMBER_OF_CANDIDATES)
        if @result.save
          format.html { redirect_to(@result, :notice => 'Result was successfully created.') }
          format.xml  { render :xml => @result, :status => :created, :location => @result }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @result.errors, :status => :unprocessable_entity }
        end
      else
        format.html {
          flash[:alert] = "You should choose " + NUMBER_OF_CANDIDATES.to_s + " candidates"
          render :edit
        }
      end
    end
  end

  # PUT /results/1
  # PUT /results/1.xml
  def update
    @result = Result.find(params[:id])

    respond_to do |format|
      if @result.update_attributes(params[:result])
        format.html { redirect_to(@result, :notice => 'Result was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @result.errors, :status => :unprocessable_entity }
      end
    end
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
