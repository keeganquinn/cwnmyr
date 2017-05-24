# This controller allows the management of Zone records.
class ZonesController < ApplicationController
  before_action :authenticate_user!, :except => [ :index, :show ]
  before_action :load_zone, :except => [ :index, :create, :new ]
  after_action :verify_authorized

  protected

  # Load a Zone record as an instance variable based on the identifier
  # provided as a request parameter.  This method is usually called as a
  # before_filter.
  def load_zone
    @zone = Zone.find_by_param(params[:id])
    redirect_to(zones_path) and return false unless @zone
  end

  public

  # Display a list of Zone records.
  def index
    @zones = Zone.paginate :page => params[:page]

    respond_to do |format|
      format.html
      format.xml  { render :xml => @zones.to_xml }
    end
  end

  # Display a single Zone record.
  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @zone.to_xml }
    end
  end

  # Display a form to allow data for a new Zone to be provided.
  def new
    @zone = Zone.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # Display a form for editing a Zone record.
  def edit
  end

  # Create a new Zone.
  def create
    @zone = Zone.new(zone_params)

    respond_to do |format|
      if @zone.save
        flash[:notice] = t('zone create success')

        format.html { redirect_to zone_path(@zone) }
        format.xml  { head :created, :location => zone_path(@zone) }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @zone.errors.to_xml }
      end
    end
  end

  # Update an existing Zone.
  def update
    respond_to do |format|
      if @zone.update_attributes(params[:zone])
        flash[:notice] = t('zone update success')

        format.html { redirect_to zone_path }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @zone.errors.to_xml }
      end
    end
  end

  # Destroy a Zone.
  def destroy
    @zone.destroy

    flash[:notice] = t('zone destroy success')

    respond_to do |format|
      format.html { redirect_to zones_path }
      format.xml  { head :ok }
      format.js   { send_js "zone_#{@zone.to_param}" }
    end
  end

  private

  def zone_params
    params.require(:zone).permit(:code, :name, :expose)
  end
end
