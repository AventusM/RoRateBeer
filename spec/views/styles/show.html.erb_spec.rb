require 'rails_helper'

RSpec.describe "styles/show", type: :view do
  before(:each) do
    @style = assign(:style, Style.create!(
      :type => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
