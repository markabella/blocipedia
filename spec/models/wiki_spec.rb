require 'rails_helper'

RSpec.describe Wiki, type: :model do
   let(:wiki) { create(:wiki) }

   describe "attributes" do
     it "has title, body, and private attributes" do
       expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, private: wiki.private)
     end

     it "is not private by default" do
       expect(wiki.private).to be(false)
     end
   end
end
