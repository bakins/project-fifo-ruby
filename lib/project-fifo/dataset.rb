class ProjectFifo
  class Dataset < ProjectFifo::Resource
    
    def initialize(fifo)
      super(fifo, 'datasets')
    end

  end
end
