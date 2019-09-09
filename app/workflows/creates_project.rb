class CreatesProject
  attr_accessor :name,:project,:task_string

  def initialize(name="",task_string="")
    @name = name
    @task_string = task_string
  end

  def build
    self.project = Project.new(name=self.name)
    project.tasks = convert_string_to_tasks
    project
  end

  def convert_string_to_tasks
    task_string.split("\n").map do |one_task|
      title,size = one_task.split(":")
      Task.new(title: title, size: size_as_integer(size))
    end
  end

  def size_as_integer(size)
    return 1 if size.blank?
    [size.to_i,1].max
  end

end
