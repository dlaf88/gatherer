require 'rails_helper'

RSpec.describe CreatesProject do

  let(:creator){CreatesProject.new(name:"Project Runway",task_string: task_string)}


  describe "initialization" do
    let(:task_string){""}
    it 'creates a project given a name' do
      creator.build
      expect(creator.project.name).to eq("Project Runway")
    end
  end

  describe 'string parsing' do
    let(:tasks){creator.convert_string_to_tasks}

      describe "creates project with empty task string" do
          let(:task_string){""}
          creator.build
          specify{expect(tasks).to be_empty}
      end

      describe'creates project with task string but no size' do
        let(:task_string){"First task"}
        creator.build
        expect(tasks.size).to eq(1)
      end

      describe 'creates project with task string with arbitrary size' do
        let(:task_string){"First task:2"}
        creator.build
        expect(tasks.first).to have_attributes(title: "First task", size: 2)
      end

      describe 'creates project with task string with size zero' do
        let(:task_string){"First task:0"}
        creator.build
        expect(tasks.first).to have_attributes(title: "First task", size: 1)
      end

      describe 'creates project with task string with malformed size' do
        let(:task_string){"First task:two"}
        creator.build
        expect(tasks.first).to have_attributes(title: "First task", size: 1)
      end

      describe 'creates project with task string with negative size' do
        let(:task_string){"First task:-1"}
        creator.build
        expect(tasks.first).to have_attributes(title: "First task", size: 1)
      end

      describe "handles multiple tasks" do
        let(:task_string){"First Task:2\nSecond task:3"}
        creator.build
        expect(tasks).to match([an_object_having_attributes(title: "First Task",size: 2),an_object_having_attributes(title: "Second task",size: 3)])
      end


  end
end
