require 'rails_helper'

RSpec.describe Project do

  let(:project){Project.new}
  let(:task){Task.new}

  it 'idenitifies a newly created project as done' do
    expect(project).to be_done

  end

  it 'detects that a project with a new task is not done' do
    project.tasks << task
    expect(project).to_not be_done

  end

  describe "estimates" do
      let(:project){Project.new}
      let(:done){Task.new({size:2,completed_date: 1.day.ago})}
      let(:small_done){Task.new({size: 1,completed_date: 1.month.ago})}
      let(:small_not_done){Task.new({size: 1})}
      let(:large_not_done){Task.new({size: 4})}
      let(:large_done){Task.new({size: 4,completed_date: 1.day.ago})}
        before(:example) do
          project.tasks = [done,small_not_done,large_not_done,small_done,large_done]
        end

        #done counts 2, 4 = 6
        #done not count = 1
        #total_done = 7
        #total_not_done = 5
        #total 12

        it "can calculate total size" do
          expect(project.total_size).to eq(12)
        end

        it "can calculate remaining size" do
          expect(project.remaining_size).to eq(5)
        end


        it 'knows its own completed task size of tasks completed within three weeks' do
          expect(project.completed_task_size).to eq(6)
        end

        it 'knows its own rate of completed tasks per day' do
          expect(project.completed_tasks_per_day).to eq(6.0/21.0)
        end

        it 'knows if its on schedule' do
          project.due_date = Time.current + 2.month
          expect(project).to be_on_schedule
        end

        it 'knows if its not on schedule' do
          project.due_date = Time.current + 1.day
          expect(project).to_not be_on_schedule
        end

  end



end
