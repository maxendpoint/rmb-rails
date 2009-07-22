#
# Listener Daemon main program
#

# Value of ARGV[0] => RAILS_ROOT
# Value of ARGV[1] => key

require 'rubygems'
require 'logger'
require 'rmb-rails'
include RMB


#
# start the daemon worker code...
#
  listener = RMB::ListenerMain.new(ARGV[0], ARGV[1])
# ...and listen forever
  listener.run


