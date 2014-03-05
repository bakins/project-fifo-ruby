require 'rest_client'
require 'json'
require 'hashie'
require 'project-fifo/resource'
require 'project-fifo/vm'
require 'project-fifo/dataset'
require 'project-fifo/package'
require 'project-fifo/iprange'
require 'project-fifo/network'

class ProjectFifo

  attr_reader :endpoint, :username, :password, :token, :ssh_keys
  
  def initialize(endpoint, username, password)
    @endpoint = endpoint
    @username = username
    @password = password
    @ssh_keys = nil
    @verbose = true
    @rest = RestClient::Resource.new(endpoint, :headers => { :content_type => 'application/json', :accept => :json })
  end
  
  def connect()
    response = post('sessions', { 'user' => @username, 'password' => @password })
    @token = response["session"]
    @ssh_keys = response["keys"]
    @rest.headers[:x_snarl_token] = @token
    response
  end
  
  def post(path_part, payload, additional_headers = {}, &block)
    api_request { @rest[path_part].post(payload.to_json, additional_headers, &block) }
  end
  
  def get(path_part, additional_headers = {}, &block)
    api_request { @rest[path_part].get(additional_headers, &block) }
  end
  
  def put(path_part, payload, additional_headers = {}, &block)
    api_request { @rest[path_part].put(payload.to_json, additional_headers, &block) }
  end
  
  def delete(path_part, additional_headers = {}, &block)
    api_request { @rest[path_part].delete(additional_headers, &block) }
  end
  
  def vms
    @vms ||= ProjectFifo::VM.new(self)
  end
  
  def datasets
    @datasets ||= ProjectFifo::Dataset.new(self)
  end
  
  def packages
    @packages ||= ProjectFifo::Package.new(self)
  end
  
  def ipranges
    @ipranges ||= ProjectFifo::Iprange.new(self)
  end
  
  def networks
    @networks ||= ProjectFifo::Network.new(self)
 end
 
  protected
  
  # inspired by https://github.com/adamhjk/dynect_rest/blob/master/lib/dynect_rest.rb
  def api_request(&block)
    response_body = begin
                      response = block.call
                      if 204 == response.code then
                        '{"success": true}'
                      else
                        response.body
                      end
                    rescue RestClient::Exception => e
                      if @verbose
                        puts "I have #{e.inspect} with #{e.http_code}"
                      end
                      e.response
                    end
    result = JSON.parse(response_body)
    return result.is_a?(Hash) ? Hashie::Mash.new(result) : result
  end
end
