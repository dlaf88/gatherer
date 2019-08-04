class Project
  attr_accessor :tasks, :due_date

  def initialize
    @tasks = []
  end

  def done?
    tasks.all?(&:completed?)
  end

  def total_size
    tasks.sum(&:size)
  end

  def remaining_size
    tasks.reject(&:completed?).sum(&:size)
  end

  def completed_task_size
    tasks.sum(&:points_toward_velocity)
  end

  def completed_tasks_per_day
    completed_task_size / 21.0
  end

  def on_schedule?
    Time.zone.today + projected_days_remaining <= due_date
  end

  def projected_days_remaining
    remaining_size/completed_tasks_per_day
  end

end
