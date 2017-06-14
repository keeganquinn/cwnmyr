class InterfacePropertyController < ApplicationController
  before_filter :login_required, :except => [ :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @interface_property = InterfaceProperty.find(params[:id])

    @page_heading = 'Interface property: ' + @interface_property.type.code
  end

  def new
    @interface_property = InterfaceProperty.new(params[:interface_property])
    @interface_property.interface = Interface.find params[:interface_id]

    @page_heading = 'New interface property'

    return unless request.post?

    if @interface_property.save
      flash[:notice] = 'Interface property was successfully created.'
      redirect_to(:controller => 'interface',
                  :action => 'show',
                  :node_code => @interface_property.interface.host.node.code,
                  :hostname => @interface_property.interface.host.name,
                  :code => @interface_property.interface.code)
    end
  end

  def edit
    @interface_property = InterfaceProperty.find(params[:id])

    @page_heading = 'Interface property: ' + @interface_property.type.code

    return unless request.post?

    if @interface_property.update_attributes(params[:interface_property])
      flash[:notice] = 'Interface property was successfully updated.'
      redirect_to :action => 'show', :id => @interface_property.id
    end
  end

  def destroy
    interface_property = InterfaceProperty.find(params[:id])
    interface = interface_property.interface
    interface_property.destroy
    flash[:notice] = 'Interface property was successfully destroyed.'
    redirect_to(:controller => 'interface',
                :action => 'show',
                :node_code => interface.host.node.code,
                :hostname => interface.host.name,
                :code => interface.code)
  end
end
