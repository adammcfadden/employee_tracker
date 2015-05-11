# ENV['RACK_ENV'] = 'development'

require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pry'
require './lib/division'
require './lib/employee'
also_reload './lib/*/**.rb'

get '/' do
  erb :index
end

get '/divisions' do
  @divisions = Division.all()
  erb :divisions
end

post '/divisions' do
  Division.create({:name => params.fetch('new_division')})
  @divisions = Division.all()
  erb :divisions
end
