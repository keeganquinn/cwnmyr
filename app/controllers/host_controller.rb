class HostController < ApplicationController
  include ActionView::Helpers::TagHelper

  before_filter :login_required, :except => [ :feed, :graph, :show ]

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @host = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname])

    @page_heading = 'Host: ' + @host.name
    @head_content = [
      tag(:link, {
            :rel => 'alternate',
            :type => 'application/atom+xml',
            :title => 'Host log feed (Atom)',
            :href => url_for(:action => 'feed',
                             :node_code => @host.node.code,
                             :hostname => @host.name)
          })
    ].join("\n")
  end

  def new
    @host = Host.new(params[:host])
    @host.node = Node.find_by_code params[:node_code]

    @page_heading = 'New host'

    return unless request.post?

    if @host.save
      flash[:notice] = 'Host was successfully created.'

      redirect_to(:action => 'show',
                  :node_code => @host.node.code,
                  :hostname => @host.name)
    end
  end

  def edit
    @host = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname])

    @page_heading = 'Host: ' + @host.name

    return unless request.post?

    if @host.update_attributes(params[:host])
      flash[:notice] = 'Host was successfully updated.'

      redirect_to(:action => 'show',
                  :node_code => @host.node.code,
                  :hostname => @host.name)
    end
  end

  def destroy
    node = Node.find_by_code(params[:node_code])
    host = node.hosts.find_by_name(params[:hostname])
    host.destroy

    flash[:notice] = 'Host was successfully destroyed.'

    redirect_to(:controller => 'node',
                :action => 'show',
                :code => node.code)
  end

  def graph
    host = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname])

    send_data(host.graph.to_png,
              :type => 'image/png', :disposition => 'inline')
  end

  def feed
    @host = Node.find_by_code(params[:node_code]).hosts.find_by_name(params[:hostname])
    render :layout => false
  end
end
