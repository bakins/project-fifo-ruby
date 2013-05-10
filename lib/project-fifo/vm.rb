

class ProjectFifo
  
  class VM < ProjectFifo::Resource
       
    def initialize(fifo)
      super(fifo, 'vms')
    end

    def get_by_alias(a)
      list.map{|i| get(i) }.select{|i| i['config']['alias'] == a }
    end
    
    def get_by_name(n)
      get_by_alias(n)
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
