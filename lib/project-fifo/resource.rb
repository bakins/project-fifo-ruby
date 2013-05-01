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
    
    def metadata(uuid, key, value)
      fifo.put([ namespace, uuid, 'metadata'].join('/'), { key => value })
    end
    
    def create(data)
      fifo.post(namespace, data)
    end
    
  end
end
