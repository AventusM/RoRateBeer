require 'rails_helper'

RSpec.describe "styles/new", type: :view do
  before(:each) do
    assign(:style, Style.new(
      :type => "MyText"
    ))
  end

  it "renders new style form" do
    render

    assert_select "form[action=?][method=?]", styles_path, "post" do

      assert_select "textarea[name=?]", "style[type]"
    end
  end
end
