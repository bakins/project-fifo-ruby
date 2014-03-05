$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'project-fifo'
require 'pp'

fifo = ProjectFifo.new("http://192.168.1.110/api/0.1.0/", "admin", "admin")

fifo.connect

package = fifo.packages.list.first
dataset = fifo.datasets.list.first
network = fifo.networks.list.first

data = {
  dataset: dataset, 
  package: package, 
  config: { 
    alias: "api-test", 
    resolvers: [ "8.8.8.8" ],
    networks: { 
      net0: network
    }
  }
}


vm = fifo.vms.create(data)

pp vm

id = vm['uuid']

sleep 60

fifo.vms.stop(id, true)

sleep 60

fifo.vms.delete(id)
