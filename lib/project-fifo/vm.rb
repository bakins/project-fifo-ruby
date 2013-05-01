class ProjectFifo
  class VM < ProjectFifo::Resource
    
    def initialize(fifo)
      super(fifo, 'vms')
    end

    %w{ start stop reboot }.each do |act|
      define_method(act) { |uuid, force| action(uuid, act, force) }
    end
    
    private
    
    def action(uuid, act, force = false)
      put(uuid, { :action => act, :force => force })
    end
    
  end
end
