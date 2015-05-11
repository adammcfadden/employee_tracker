ENV['RACK_ENV'] = 'development'

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
  @employees = Employee.all()
  erb :divisions
end

post '/divisions' do
  Division.create({:name => params.fetch('new_division')})
  @divisions = Division.all()
  @employees = Employee.all()
  erb :divisions
end

get '/divisions/:id' do
  @division = Division.find(params.fetch('id').to_i())
  @employees = Employee.get_by_division_id(@division.id)
  erb :division
end

get '/divisions/:id/:selector' do
  @selector = params.fetch('selector')
  @division = Division.find(params.fetch('id').to_i())
  @employees = Employee.get_by_division_id(@division.id)
  @out_employees = Employee.get_division_id_inverse(@division.id)
  erb(:division)
end

patch '/divisions/:id' do
   @division = Division.find(params.fetch('id').to_i())
   @division.update({:name => params.fetch('new_name')})
   @employees = Employee.get_by_division_id(@division.id)
   erb(:division)
end

delete '/divisions/:id' do
  @division = Division.find(params.fetch('id').to_i())
  @division.delete
  @divisions = Division.all()
  @employees = Employee.all()
  erb(:divisions)
end

post '/divisions/employee' do
  Employee.create({:name => params.fetch('new_employee')})
  @divisions = Division.all()
  @employees = Employee.all()
  erb(:divisions)
end

patch '/divisions/:id/employee' do
  selected_employees = []
  params.fetch('employee_ids').each() do |employee_id|
    selected_employees.push(Employee.find(employee_id.to_i()))
  end
  selected_employees.each() do |employee|
    employee.update({:division_id => params.fetch('id')})
  end
  @division = Division.find(params.fetch('id').to_i())
  @employees = Employee.get_by_division_id(@division.id())
  erb(:division)
end
