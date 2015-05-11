require('capybara/rspec')
require('./app')

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
