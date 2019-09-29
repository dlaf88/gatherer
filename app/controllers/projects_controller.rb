class ProjectsController < ApplicationController
  def new
    @project = Project.new()
  end

  def create
    @workflow = CreatesProject.new(name:params[:project][:name],task_string: params[:project][:tasks])
    if @workflow.create
      redirect_to projects_path
    else
      redirect_to new_project_path
    end
  end

  def index
    @projects = Project.all
  end
end
