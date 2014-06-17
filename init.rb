require 'sinatra'
require 'sinatra/reloader' if development?

require './browseractions'

BrowserActions.run!({
  :bind => '0.0.0.0',
  :port => 4567,
  #:server => 'thin'
})