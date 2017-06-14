class HostTypesController < ApplicationController
  before_filter :login_required, :except => [ :index, :show ]
  before_filter :load_host_type, :except => [ :index, :create, :new ]

  protected

  # Load a HostType record as an instance variable based on the identifier
  # provided as a request parameter. This method is usually called as a
  # before_filter.
  def load_host_type
    @host_type = HostType.find_by_param(params[:id])
    redirect_to(host_types_path) and return false unless @host_type
  end

  public

  # Display a list of HostType records.
  def index
    @host_types = HostType.paginate :page => params[:page]

    respond_to do |format|
      format.html
      format.xml  { render :xml => @host_types.to_xml }
    end
  end

  # Display a single HostType record.
  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @host_type.to_xml }
    end
  end

  # Display a form to allow data for a new HostType to be provided.
  def new
    @host_type = HostType.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # Display a form for editing a HostType record.
  def edit
  end

  # Create a new HostType.
  def create
    @host_type = HostType.new(params[:host_type])

    respond_to do |format|
      if @host_type.save
        flash[:notice] = t('host type create success')

        format.html { redirect_to host_type_path(@host_type) }
        format.xml  { head :created, :location => host_type_path(@host_type) }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @host_type.errors.to_xml }
      end
    end
  end

  # Update an existing HostType.
  def update
    respond_to do |format|
      if @host_type.update_attributes(params[:host_type])
        flash[:notice] = t('host type update success')

        format.html { redirect_to host_type_path }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @host_type.errors.to_xml }
      end
    end
  end

  # Destroy a HostType.
  def destroy
    @host_type.destroy

    flash[:notice] = t('host type destroy success')

    respond_to do |format|
      format.html { redirect_to host_types_path }
      format.xml  { head :ok }
      format.js   { send_js "host_type_#{@host_type.to_param}" }
    end
  end

  # ATOM feed for HostTypeComment records.
  def comments
  end
end
