class ProjectFifo
  class Network < ProjectFifo::Resource
    
    def initialize(fifo)
      super(fifo, 'networks')
    end

  end
end
