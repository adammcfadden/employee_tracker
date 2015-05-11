require('capybara/rspec')
require('./app')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("The path to the index page.", {:type => :feature}) do
  it("Displays a welcome page.") do
    visit('/')
    expect(page).to(have_content("Employee Tracker"))
  end
end

describe('The path to show all divisions', {:type => :feature}) do
  it("Displays a divisions page.") do
    visit('/')
    click_button('divisions')
    expect(page).to have_content('Divisions:')
  end
end

describe('The path to add a new division', {:type => :feature}) do
  it('will let user input division name, and see that division added.') do
    visit('/divisions')
    fill_in('new_division', :with => 'Customer Service')
    click_button('add_division')
    expect(page).to have_content('Customer Service')
  end
end

describe("The path to visit a division's individual page", {:type => :feature}) do
  it("will display the name of the division at the top of the page.") do
    test_division = Division.create({:name => "R&D"})
    visit('/divisions')
    click_link(test_division.id)
    expect(page).to_not have_content('Enter a new Division Name:')
    expect(page).to have_content('R&D')
  end
end

describe('The path to alter a division', {:type => :feature}) do
  before(:each) do
    test_division = Division.create({:name => "R&D"})
    visit('/divisions')
    click_link(test_division.id)
  end
  it('will click the delete button and delete the division') do
    click_button('delete_division')
    expect(page).to_not have_content("R&D")
  end
  it('will click the update button and update the division') do
    click_button('update')
    fill_in('new_name', :with => 'Customer Service')
    click_button('update_division')
    expect(page).to have_content('Customer Service')
  end
end

describe("The path to add an employee", {:type => :feature}) do
  it("It displays a form and a button to add an employee.") do
    visit('/divisions')
    fill_in('new_employee', :with => 'Dave Blanket')
    click_button('add_employee')
    expect(page).to have_content('Dave Blanket')
  end
end

describe('The path to attach an employee to a division', {:type => :feature}) do
  it('shows a checklist of available employees, and allows them to be added to the division') do
    test_division = Division.create({:name => "R&D"})
    test_employee1 = Employee.create({:name => "tom"})
    test_employee2 = Employee.create({:name => "bob"})
    visit('/divisions')
    click_link(test_division.id)
    click_button('reveal_employee_list')
    check(test_employee1.id)
    check(test_employee2.id)
    click_button('attach_employees')
    expect(page).to have_content('tom')
    expect(page).to have_content('bob')
  end
end
