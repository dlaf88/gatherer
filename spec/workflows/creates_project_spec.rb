require 'rails_helper'

RSpec.describe CreatesProject do
  describe "initialization" do
    it 'creates a project given a name' do
      creator = CreatesProject.new(name:"Project Runway")
      creator.build
      expect(creator.project.name).to eq("Project Runway")
    end
  end

  describe 'string parsing' do
    it "creates project with empty task string" do
      creator = CreatesProject.new(name: "Project Runway", task_string:"")
      creator.build
      creator.convert_string_to_tasks
      expect(creator.project.tasks).to be_empty
    end

  end
end
