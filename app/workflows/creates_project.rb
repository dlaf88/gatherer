class CreatesProject
  attr_accessor :name,:project,:tasks

  def initialize(name="",tasks=[])
    @name = name
  end

  def build
    self.project = Project.new(name=self.name)
  end

end
