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

  
    end

  end
end
