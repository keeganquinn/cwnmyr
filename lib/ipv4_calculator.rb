# $Id: ipv4_calculator.rb 2738 2006-06-10 08:35:28Z keegan $
#
# This Ipv4Calculator module provides the means to deal with inter-domain Ipv4
# routing calculations in an object-oriented fashion.
#
# An Ipv6 equivalent should probably exist at some point, although many of
# these functions are not useful for Ipv6.
#
# Copyright 2006 Keegan Quinn
# Copyright (c) 2001 Dr Balwinder S Dheeman (bsd.SANSPAM@cto.homelinux.net)
#
# This module is derived from Dr. Dheeman's work:
#
# "An ICALC module and Simple IP calculator sub/super networking"
#
#--
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#++

module Ipv4Calculator
  # Maximum allowable IPv4 integer address
  MAX = 4294967295

  # The Subnet class models any IP network or subnetwork.
  class Subnet
    include Ipv4Calculator

    attr :cidr_notation
    attr :divisor

    def initialize(value, init_divisor = 1)
      # TODO validate here.

      @cidr_notation = value
      @divisor = init_divisor
    end

    def address
      @cidr_notation.split("/")[0]
    end

    def base_prefix
      @cidr_notation.split("/")[1].to_i
    end

    def base_netmask_i
      (MAX >> (32 - base_prefix)) << (32 - base_prefix)
    end

    def base_netmask
      Ipv4Calculator::to_dotted_quad(base_netmask_i)
    end

    def netsize
      (MAX ^ base_netmask_i) + 1
    end

    def factor
      netsize.div(@divisor)
    end

    def to_i
      a, b, c, d = address.split(".")
      a.to_i * 16777216 + b.to_i * 65536 + c.to_i * 256 + d.to_i
    end

    def prefix
      return base_prefix unless @divisor > 1

      divisor_index = 1
      result = base_prefix

      while divisor_index < @divisor and netsize.div(divisor_index) > 4
        divisor_index <<= 1
        result += 1
      end

      result
    end

    def network_i
      to_i & netmask_i
    end

    def netmask_i
      MAX - factor + 1
    end

    def inverse_netmask_i
      MAX ^ netmask_i
    end

    def first_host_i
      network_i + 1
    end

    def broadcast_i
      network_i + factor - 1
    end

    def last_host_i
      broadcast_i - 1
    end

    def network
      Ipv4Calculator::to_dotted_quad(network_i)
    end

    def netmask
      Ipv4Calculator::to_dotted_quad(netmask_i)
    end

    def inverse_netmask
      Ipv4Calculator::to_dotted_quad(inverse_netmask_i)
    end

    def first_host
      Ipv4Calculator::to_dotted_quad(first_host_i)
    end

    def broadcast
      Ipv4Calculator::to_dotted_quad(broadcast_i)
    end

    def last_host
      Ipv4Calculator::to_dotted_quad(last_host_i)
    end

    def internet_class
      case Ipv4Calculator::to_binary_quad(network_i)
      when /^0/ then 'Class A'
      when /^10/ then 'Class B'
      when /^110/ then 'Class C'
      when /^1110/ then 'Class D'
      when /^11110/ then 'Class E'
      else 'Undefined class'
      end
    end

    def subnets
      result = []

      (1 .. @divisor).each do |index|
        result.push Subnet.new(Ipv4Calculator::to_dotted_quad(network_i - factor + (factor * index)) + '/' + prefix.to_s)
      end

      result
    end
  end

  # Convert an integer IP address to a dotted binary IP address.
  def self.to_binary_quad(integer_ip)
    raise TypeError, 'Value out of range' if 0 > integer_ip or integer_ip > MAX

    bin = sprintf "%032b\n", integer_ip

    bin[0..7] + '.' + bin[8..15] + '.' + bin[16..23] + '.' + bin[24..31]
  end

  # Convert an integer IP address to a dotted decimal IP address.
  def self.to_dotted_quad(integer_ip)
    raise TypeError, 'Value out of range' if 0 > integer_ip or integer_ip > MAX

    d = integer_ip % 256
    c = (integer_ip >> 8) % 256
    b = (integer_ip >> 16) % 256
    a = integer_ip >> 24

    a.to_s + '.' + b.to_s + '.' + c.to_s + '.' + d.to_s
  end

  def self.subnet_neighbor_match?(address_l, address_r)
    address_l = Subnet.new(address_l) unless address_l.class == Subnet
    address_r = Subnet.new(address_r) unless address_r.class == Subnet

    (address_l.network_i == address_r.network_i) &&
      (address_l.netmask_i == address_r.netmask_i)
  end
end
