class ProjectFifo
  class VM < ProjectFifo::Resource
    
    def initialize(fifo)
      super(fifo, 'vms')
    end

  end
end
