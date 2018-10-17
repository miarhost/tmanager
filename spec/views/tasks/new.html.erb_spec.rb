require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      :name => "MyString",
      :priority => 1,
      :project => nil,
      :done => false
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input[name=?]", "task[name]"

      assert_select "input[name=?]", "task[priority]"

      assert_select "input[name=?]", "task[project_id]"

      assert_select "input[name=?]", "task[done]"
    end
  end
end
