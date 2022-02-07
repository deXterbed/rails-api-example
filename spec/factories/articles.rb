FactoryBot.define do
  factory :article do
    title {|n| "Sample article #{n}" }
    content {|n| "Sample content #{n}" }
    slug { title.split(' ').join('-') }
  end
end
