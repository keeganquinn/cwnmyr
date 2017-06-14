class NodeLinkController < ApplicationController
  before_filter :login_required

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @node_link = NodeLink.find(params[:id])

    unless logged_in? or @node_link.active?
      redirect_to(:controller => 'welcome') and return
    end

    @page_heading = 'Node link: ' + @node_link.name
  end

  def new
    @node_link = NodeLink.new(params[:node_link])
    @node_link.node = Node.find params[:node_id]

    @page_heading = 'New node link'

    return unless request.post?

    if @node_link.save
      flash[:notice] = 'Node link was successfully created.'
      redirect_to :controller => 'node', :action => 'show',
        :code => @node_link.node.code
    end
  end

  def edit
    @node_link = NodeLink.find(params[:id])

    @page_heading = 'Node link: ' + @node_link.name

    return unless request.post?

    if @node_link.update_attributes(params[:node_link])
      flash[:notice] = 'Node link was successfully updated.'
      redirect_to :action => 'show', :id => @node_link.id
    end
  end

  def destroy
    node_link = NodeLink.find(params[:id])
    node = node_link.node
    node_link.destroy
    flash[:notice] = 'Node link was successfully destroyed.'
    redirect_to :controller => 'node', :action => 'show', :code => node.code
  end
end
