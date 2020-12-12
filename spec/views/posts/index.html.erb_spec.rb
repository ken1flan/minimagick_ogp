require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        body: "Body"
      ),
      Post.create!(
        body: "Body"
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", text: "Body".to_s, count: 2
  end
end
