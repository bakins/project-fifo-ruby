class ProjectFifo
  class Iprange < ProjectFifo::Resource
    
    def initialize(fifo)
      super(fifo, 'ipranges')
    end

  end
end
