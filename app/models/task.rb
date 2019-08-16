class Task < ApplicationRecord
  belongs_to :project

  def after_initialize()
    completed_at = attributes[:completed_date] if attributes[:completed_date].present?
    size = attributes[:size] if attributes[:size].present?
  end


  def mark_completed(date: Time.current)
    self.completed_at = date
  end

  def completed?
    completed_at.present?
  end

 def points_toward_velocity
   counts_toward_velocity? ? size : 0
 end

 def counts_toward_velocity?
   return false unless completed?
   completed_at > Project.velocity_days_in_days.days.ago
 end
end
