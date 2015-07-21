($LOAD_PATH << '.' << 'lib' ).uniq!
require 'sidekiq_worker'