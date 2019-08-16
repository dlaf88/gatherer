class Project < ApplicationRecord
  has_many :task,dependent: :destroy

  def self.velocity_days_in_days
    21
  end

  def incomplete_tasks
    tasks.reject(&:completed?)
  end

  def done?
    incomplete_tasks.empty?
  end

  def total_size
    tasks.sum(&:size)
  end

  def remaining_size
    incomplete_tasks.sum(&:size)
  end

  def completed_task_size
    tasks.sum(&:points_toward_velocity)
  end

  def completed_tasks_per_day
    completed_task_size *1.0 / Project.velocity_days_in_days
  end

  def projected_days_remaining
    remaining_size/completed_tasks_per_day
  end

  def on_schedule?
    return false if projected_days_remaining.nan?
    (Time.zone.today + projected_days_remaining) <= due_date
  end

end
