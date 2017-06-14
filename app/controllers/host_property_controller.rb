class HostPropertyController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @host_property = HostProperty.find(params[:id])

    @page_heading = 'Host property: ' + @host_property.type.code
  end

  def new
    @host_property = HostProperty.new(params[:host_property])
    @host_property.host = Host.find params[:host_id]

    @page_heading = 'New host property'

    return unless request.post?

    if @host_property.save
      flash[:notice] = 'Host property was successfully created.'
      redirect_to(:controller => 'host',
                  :action => 'show',
                  :node_code => @host_property.host.node.code,
                  :hostname => @host_property.host.name)
    end
  end

  def edit
    @host_property = HostProperty.find(params[:id])

    @page_heading = 'Host property: ' + @host_property.type.code

    return unless request.post?

    if @host_property.update_attributes(params[:host_property])
      flash[:notice] = 'Host property was successfully updated.'
      redirect_to :action => 'show', :id => @host_property.id
    end
  end

  def destroy
    host_property = HostProperty.find(params[:id])
    host = host_property.host
    host_property.destroy
    flash[:notice] = 'Host property was successfully destroyed.'
    redirect_to(:controller => 'host',
                :action => 'show',
                :node_code => host.node.code,
                :hostname => host.name)
  end
end
