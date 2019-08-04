require 'rails_helper'

RSpec.describe Project do

  it 'idenitifies a newly created project as done' do
    project = Project.new
    expect(project.done?).to(be_truthy)

  end

  it 'detects that a project with a new task is not done' do
    project = Project.new
    task = Task.new
    project.tasks << task
    expect(project.done?).to be_falsy


  end

end
