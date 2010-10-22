# $Id: mime_test.rb 5 2007-07-18 16:41:01Z vegan420 $
# Copyright 2007 Keegan Quinn

module MimeTest
  module Assertions
    # Assertion for use in response testing.  Verifies that the most recent
    # request responded with an appropriate MIME type, as interpreted by
    # the response_type_to_mime_type method.
    def assert_responded_with(s)
      assert_equal "#{response_type_to_mime_type(s)}", @response.content_type
    end

    # Sends an HTTP GET request with a specific MIME type.
    def get_with(type, *arguments)
      with_type type, :get, *arguments
    end  

    # Sends an HTTP POST request with a specific MIME type.
    def post_with(type, *arguments)
      with_type type, :post, *arguments
    end

    # Sends an HTTP PUT request with a specific MIME type.
    def put_with(type, *arguments)
      with_type type, :put, *arguments
    end

    # Sends an HTTP DELETE request with a specific MIME type.
    def delete_with(type, *arguments)
      with_type type, :delete, *arguments
    end

    # Calls a method (usually an HTTP method) with a specific Accept header.
    def with_type(type, method, *arguments)
      accept type
      send method, *arguments

      # Reset the request to accept HTML after  
      accept :html  
    end

    # Switches the request object's Accept header to a new type, which may
    # be any type supported by the response_type_to_mime_type method.
    def accept(type)
      @request.accept = response_type_to_mime_type(type)
    end

    # Convert a response type symbol to a MIME type string using the
    # Mime module.
    def response_type_to_mime_type(s)
      Mime::EXTENSION_LOOKUP[s.to_s]
    end
  end
end
