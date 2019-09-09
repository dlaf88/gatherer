class ProjectsController < ApplicationController
  def new
    @project = Project.new()
  end

  def create
    @workflow = CreatesProject.new(name:params[:project][:name])
  end

  def index
    @projects = Project.all
  end
end
