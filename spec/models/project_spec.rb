require 'rails_helper'

RSpec.describe Project do

  it 'idenitifies a newly created project as done' do
    project = Project.new
    expect(project.done?).to(be_truthy)

  end



end
