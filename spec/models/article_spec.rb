require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '#validations' do
    let(:article) { build(:article) }

    it 'tests that factory is valid' do
      expect(article).to be_valid
    end

    it 'has an invalid title' do
      article.title = ''
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include('can\'t be blank')
    end
  end

  describe '.recent' do
    it 'returns articles in the correct order' do
      old_article = create(:article, created_at: 1.hour.ago)
      recent_article = create(:article)

      expect(described_class.recent).to eq(
        [recent_article, old_article]
      )

      recent_article.update_column(:created_at, 2.hours.ago)
      expect(described_class.recent).to eq(
        [old_article, recent_article]
      )
    end
  end
end
