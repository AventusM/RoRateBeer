require 'rails_helper'

RSpec.describe "styles/edit", type: :view do
  before(:each) do
    @style = assign(:style, Style.create!(
      :type => "MyText"
    ))
  end

  it "renders the edit style form" do
    render

    assert_select "form[action=?][method=?]", style_path(@style), "post" do

      assert_select "textarea[name=?]", "style[type]"
    end
  end
end
