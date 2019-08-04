require 'rails_helper'

RSpec.describe Task do

  let(:task){Task.new}

  it 'states that a new task is not completed' do
    expect(task).to_not be_completed
  end


  it 'indicates that a task that is marked completed is complete' do
    task.mark_completed
    expect(task).to be_completed
  end

  describe "velocity" do
    let(:task){Task.new({size: 3})}

    it "is not counted by an incomplete task" do
      expect(task.points_toward_velocity).to eq(0)
    end

    it "is counted by a recently completed task" do
      task.mark_completed(date: 1.day.ago)
      expect(task.points_toward_velocity).to eq(3)
    end

    it "is not increased by a completed task long ago" do
      task.mark_completed(date: 1.month.ago)
      expect(task.points_toward_velocity).to eq(0)
    end
  end

end
