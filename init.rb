require 'sinatra'
require 'sinatra/reloader' if development?

$keys_time = {}
$keys_list = {}
$keys_list['available'] = []
$keys_list['blocked'] = []

require './browseractions'

BrowserActions.run!({
  :bind => '0.0.0.0',
  :port => 4567,
  #:server => 'thin'
})