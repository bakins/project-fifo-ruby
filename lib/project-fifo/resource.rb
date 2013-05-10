require 'hash_validator'

class ProjectFifo
  class Resource
    
    attr_reader :fifo, :namespace
    
    def initialize(fifo, namespace)
      @namespace = namespace
      @fifo = fifo
    end
    
    def list
      fifo.get(namespace)
    end
    
    # alias didn't work. research it
    def [](uuid)
      get(uuid)
    end
    
    def get(uuid)
        fifo.get(namespace + '/' + uuid)
    end
    
    def get_by_name(name)
      list.map{|i| get(i) }.select{|i| i['name'] == name}
    end

    def metadata(uuid, key, value)
      fifo.put([ namespace, uuid, 'metadata'].join('/'), { key => value })
    end
    
    def create(data)
      validate!(data)
      fifo.post(namespace, data)
    end
    
    def delete(uuid)
      fifo.delete(namespace + '/' + uuid)
    end
    
    def post(uuid, payload)
      fifo.post(namespace + '/' + uuid, payload)
    end
    
    def put(uuid, payload)
      fifo.put(namespace + '/' + uuid, payload)
    end 

    protected
    def validate!(data)
      validator = HashValidator.validate(data, validations)
      raise(ArgumentError, validator.errors) unless validator.valid?
    end
    
    def validations()
      return {}
    end
  end
end
