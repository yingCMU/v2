class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    if params[:search].present?
      @locations = Location.near(params[:search], 50, :order => :distance)
    else
      @locations = Location.all
    end



    @json = @locations.to_gmaps4rails

    respond_to do |format|
      format.html # index.html.erb

    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])
    @json =@location.to_gmaps4rails
    respond_to do |format|
      format.html # show.html.erb

    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb

    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location}

      else
        format.html { render  "new" }

      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location }
        format.json { head :no_content }
      else
        format.html { render  "edit" }

      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end



  def search
    @keywords = params[:keywords]
    if not @keywords.nil?
      if not @keywords.strip.empty?


        #results = Location.search(@keywords, @page, @items_per_page)
        @items = results[0]
        @count = results[1]
        @locations = Location.all
        @json = Location.all.to_gmaps4rails

        respond_to do |format|
          format.html # show.html.erb

        end
      else
        redirect_to request.referer || :root
      end
    else
      redirect_to :root
    end
  end
end
