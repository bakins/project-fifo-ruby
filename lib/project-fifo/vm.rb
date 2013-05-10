

class ProjectFifo
  
  class VM < ProjectFifo::Resource
          
    def initialize(fifo)
      super(fifo, 'vms', 'alias')
    end

    %w{ start stop reboot }.each do |act|
      define_method(act) { |uuid, force| action(uuid, act, force) }
    end
    
     VALIDATIONS = {
      package: 'string',
      dataset: 'string',
      config: {
        alias: 'string',
        networks: {
          net0: 'string'
        }
      }
    }
    
    protected
    def validations()
      return VALIDATIONS
    end
    
    private
    
    def action(uuid, act, force = false)
      put(uuid, { :action => act, :force => force })
    end
    
  end
end
