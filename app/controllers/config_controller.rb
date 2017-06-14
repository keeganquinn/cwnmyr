class ConfigController < ApplicationController
  # Display a listing of available configuration files.
  def index
  end

  # This action can be used to download a BIND DNS zone representing
  # all hosts with external (Internet-facing) Interface instances.
  def dns_zone_external
    response.content_type = 'text/plain'
    render :layout => false
  end

  # This action can be used to download a BIND DNS zone representing
  # all hosts with internal Interface instances.
  def dns_zone_internal
    response.content_type = 'text/plain'
    render :layout => false
  end

  # This action can be used to download a Smokeping configuration file
  # representing all hosts with external (Internet-facing) Interface
  # instances.
  def smokeping_external
    response.content_type = 'text/plain'
    render :layout => false
  end

  # This action can be used to download a Smokeping configuration file
  # representing all hosts with internal Interface instances.
  def smokeping_internal
    response.content_type = 'text/plain'
    render :layout => false
  end

  # This action can be used to download a Nagios configuration file
  # representing all hosts with external (Internet-facing) Interface
  # instances.
  def nagios_external
    response.content_type = 'text/plain'
    render :layout => false
  end

  # This action can be used to download a Nagios configuration file
  # representing all hosts with internal Interface instances.
  def nagios_internal
    response.content_type = 'text/plain'
    render :layout => false
  end
end
