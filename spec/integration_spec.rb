require("capybara/rspec")
require("./app")
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new list', {:type => :feature}) do
  it("allows a user to click a list to see the tasks and details for it") do
    visit('/')
    click_link('Add New List')
    fill_in('name', :with => 'Moringaschool Work')
    click_button('Add List')
    expect(page).to have_content('Success!')
  end
end

describe("viewing all of the lists", {:type => :feature}) do
  it("allows a user to see all of the lists that have been created") do
    list = List.new({:name => 'Moringaschool Homework', :id => nil})
    list.save()
    visit('/')
    click_link('View All Lists')
    expect(page).to have_content(list.name)
  end
end

describe("adding tasks to a list", {:type => :feature}) do
  it("allows a uswer to add a task to a list") do
    test_list = List.new({:name => "School stuff", :id => nil})
    test_list.save()
    visit("/lists/#{test_list.id()}")
    fill_in("Description", {:with => "Learn SQL"})
    click_button("Add task")
    expect(page).to have_content("Success")
  end
end
