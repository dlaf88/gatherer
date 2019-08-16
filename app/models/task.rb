class Task
  belongs_to :project


  def mark_completed(date: Time.current)
    completed_at = date
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
