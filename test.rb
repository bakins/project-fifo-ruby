$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'project-fifo'
require 'pp'

fifo = ProjectFifo.new("http://192.168.1.100/api/0.1.0/", "admin", "admin")

fifo.connect

fifo.vms.list.each do |vm|
  pp fifo.vms[vm]
end

package = fifo.packages.list.first
dataset = fifo.datasets.list.first
iprange = fifo.ipranges.list.first

data = {
  dataset: dataset, 
  package: package, 
  config: { 
    alias: "api-test", 
    resolvers: [ "8.8.8.8" ],
    ssh_keys: fifo.ssh_keys,
    networks: { 
      net0: iprange
    }
  }
}

pp data

pp fifo.vms.create(data)
