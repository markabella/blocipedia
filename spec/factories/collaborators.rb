FactoryGirl.define do
  factory :collaborator do
    user_id 1
    wiki_id 1
    email "MyString"
    wiki nil
    user nil
  end
end
