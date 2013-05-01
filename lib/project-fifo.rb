require 'rest_client'
require 'json'
require 'project-fifo/resource'
require 'project-fifo/vm'
require 'project-fifo/dataset'
require 'project-fifo/package'

class ProjectFifo

  attr_reader :endpoint, :username, :password, :token
  
  def initialize(endpoint, username, password)
    @endpoint = endpoint
    @username = username
    @password = password
    @verbose = true
    @rest = RestClient::Resource.new(endpoint, :headers => { :content_type => 'application/json', :accept => :json })
  end
  
  def connect()
    response = post('sessions', { 'user' => @username, 'password' => @password })
    @token = response["session"]
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
  
  def vms
    ProjectFifo::VM.new(self)
  end
  
  def datasets
    ProjectFifo::Dataset.new(self)
  end
  
  def packages
    ProjectFifo::Package.new(self)
  end
  
  protected
  
  # inspired by https://github.com/adamhjk/dynect_rest/blob/master/lib/dynect_rest.rb
  def api_request(&block)
    response_body = begin
                      response = block.call
                      response.body
                    rescue RestClient::Exception => e
                      if @verbose
                        puts "I have #{e.inspect} with #{e.http_code}"
                        pp e
                      end
                      e.response
                    end
    JSON.parse(response_body)
  end
end