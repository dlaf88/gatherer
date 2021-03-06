require 'rails_helper'

RSpec.describe CreatesProject do
  describe "initialization" do
    it 'creates a project given a name' do
      creator = CreatesProject.new(name: "Project Runway")
      creator.build
      expect(creator.project.name).to eq("Project Runway")
    end
  end

  describe 'string parsing' do
    it "creates project with empty task string" do
      creator = CreatesProject.new(name: "Project Runway",task_string: "")
      tasks = creator.convert_string_to_tasks
      expect(tasks).to be_empty
    end

    it 'creates project with task string but no size' do
      creator = CreatesProject.new(name: "Project Runway",task_string: "This is the first task")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
    end

    it 'creates project with task string with arbitrary size' do
      creator = CreatesProject.new(name: "Project Runway",task_string: "This is the first task:2")
      tasks = creator.convert_string_to_tasks
      expect(tasks.first).to have_attributes(title: "This is the first task", size: 2)
    end

    it 'creates project with task string with size zero' do
      creator = CreatesProject.new(name: "Project Runway",task_string: "This is the first task:0")
      tasks = creator.convert_string_to_tasks
      expect(tasks.first).to have_attributes(title: "This is the first task", size: 1)
    end

    it 'creates project with task string with malformed size' do
      creator = CreatesProject.new(name: "Project Runway",task_string: "This is the first task:two")
      tasks = creator.convert_string_to_tasks
      expect(tasks.first).to have_attributes(title: "This is the first task", size: 1)
    end

    it 'creates project with task string with negative size' do
      creator = CreatesProject.new(name: "Project Runway",task_string: "This is the first task:-1")
      tasks = creator.convert_string_to_tasks
      expect(tasks.first).to have_attributes(title: "This is the first task", size: 1)
    end

    it "handles multiple tasks" do
      creator = CreatesProject.new(name: "",task_string: "First Task:2\nSecond task:3")
      tasks = creator.convert_string_to_tasks
      expect(tasks).to match([an_object_having_attributes(title: "First Task",size: 2),an_object_having_attributes(title: "Second task",size: 3)])
    end


  end


  describe 'failures states' do
    it 'fails when there is no name' do
        creator = CreatesProject.new(name: "",task_string: "First Task:2\nSecond task:3")
        creator.create
        expect(creator).to_not be_a_success

    end
  end
end
