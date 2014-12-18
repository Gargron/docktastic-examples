require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require 'haml'
require 'socket'

class Example < Sinatra::Base
  get '/' do
    @env_vars = ENV
    @hostname = Socket.gethostname

    haml :index
  end
end
