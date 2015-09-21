require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  let(:user) { create(:user) }

    describe "display_user_posts" do
      it "determines if the user has no posts" do
        expected_text = "#{user.name} does not have any posts."
        expect(display_user_posts(user)).to eq expected_text
      end
    end

    describe "display_user_comments" do
      it "determines if the user has no comments" do
        expected_text = "#{user.name} has not commented on anything."
        expect(display_user_comments(user)).to eq expected_text
    end
  end
end
