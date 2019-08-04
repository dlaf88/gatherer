class Task
 attr_accessor :size,:completed_date

  def initialize(options = {})
    @completed_date = options[:completed_date] if options[:completed_date]
    @size = options[:size]
  end

  def mark_completed(date: Time.current)
    @completed_date = date
    @completed = true
  end

  def completed?
    return true if completed_date
    false
  end

 def points_toward_velocity
   counts_toward_velocity? ? size : 0
 end

 def counts_toward_velocity?
   if(completed? && (completed_date >= 21.days.ago))
     return true
  end
    return false
 end

end
