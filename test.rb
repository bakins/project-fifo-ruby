$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'project-fifo'
require 'pp'

fifo = ProjectFifo.new("http://192.168.1.100/api/0.1.0/", "admin", "admin")

fifo.connect

fifo.vms.list.each do |vm|
  pp fifo.vms[vm]
end

fifo.datasets.list.each do |dataset|
  pp fifo.datasets[dataset]
end

fifo.packages.list.each do |package|
  pp fifo.packages[package]
end
