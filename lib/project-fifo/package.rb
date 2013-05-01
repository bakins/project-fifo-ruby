class ProjectFifo
  class Package < ProjectFifo::Resource
    
    def initialize(fifo)
      super(fifo, 'packages')
    end

  end
end
