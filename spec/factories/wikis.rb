 FactoryGirl.define do
   factory :wiki do
     title RandomData.random_name
     body RandomData.random_paragraph
   end
 end