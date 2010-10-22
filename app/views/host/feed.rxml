xml.instruct!

xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do

  xml.title   "Host: " + @host.name
  xml.link    "rel" => "self", "href" => url_for(:only_path => false, :controller => 'host', :action => 'feed', :node_code => @host.node.code, :hostname => @host.name)
  xml.link    "rel" => "alternate", "href" => url_for(:only_path => false, :controller => 'host', :action => 'show', :node_code => @host.node.code, :hostname => @host.name)
  xml.id      url_for(:only_path => false, :controller => 'host', :action => 'show', :node_code => @host.node.code, :hostname => @host.name)
  xml.updated @host.logs.first.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ") if @host.logs.any?

  @host.logs.find_all_by_active(true).each do |log|
    xml.entry do
      xml.title   log.subject
      xml.link    "rel" => "alternate", "href" => url_for(:only_path => false, :controller => 'host_log', :action => 'show', :id => log.id)
      xml.id      url_for(:only_path => false, :controller => 'host_log', :action => 'show', :id => log.id)
      xml.updated log.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")
      xml.author  { xml.name log.user.login }
      xml.content "type" => "html" do
        xml.text! render(:partial => "host_log/entry", :locals => { :log => log })
      end
    end
  end

end
