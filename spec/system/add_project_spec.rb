RSpec.describe "adding a new project",type: :system do
  it "allows a user to create a project with tasks" do
    visit new_project_path
    fill_in "Name",with: "Project Runway"
    fill_in "Tasks",with: "Choose Fabric:3\nMake it Work:5"
    click_on("Create Project")
    visit projects_path
    @project = Project.find_by(name: "Project Runway")
    expect(page).to have_selector("#project_#{@project.id}_name",text: "Project Runway")
    expect(page).to have_selector("#project_#{@project.id}_size",text: 8)
  end

  it 'does not allow a user to create a project with no name' do
    visit new_project_path
    fill_in "Name",with: ""
    fill_in "Tasks",with: "Choose Fabric:3\nMake it Work:5"
    click_on("Create Project")
    expect(page).to have_selector(".new_project")
  end
end
