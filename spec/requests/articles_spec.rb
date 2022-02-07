require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe '#index' do
    it 'returns a success response' do
      get '/articles'
      expect(response).to have_http_status(:ok)
    end

    it 'returns a proper JSON' do
      article = create(:article)
      get '/articles'
      expect(json_data.length).to eq(1)
      expected = json_data[0]
      expect(expected[:id]).to eq(article.id.to_s)
      expect(expected[:type]).to eq('article')
      expect(expected[:attributes]).to eq(
        {
          title: article.title,
          content: article.content,
          slug: article.slug
        }
      )
    end

    it 'returns articles in the proper order' do
      old_article = create(:article, created_at: 1.hour.ago)
      recent_article = create(:article)

      get '/articles'

      ids = json_data.map{ |item| item[:id].to_i }
      expect(ids).to eq([recent_article.id, old_article.id])
    end

    it 'paginates results' do
      article1, article2, article3 = create_list(:article, 3)
      get '/articles', params: {page: {number: 2, size: 1}}
      expect(json_data.length).to eq(1)
      expect(json_data[0][:id]).to eq(article2.id.to_s)
    end

    it 'pagination links in the response' do
      article1, article2, article3 = create_list(:article, 3)
      get '/articles', params: {page: {number: 2, size: 1}}
      expect(json[:links].length).to eq(5)
      expect(json[:links].keys).to contain_exactly(
        :first, :prev, :next, :last, :self
      )
    end
  end

  describe '#show' do
    context "when article exists" do
      it 'returns a success response' do
        article = create(:article)
        get "/articles/#{article.id}"

        expect(response).to have_http_status(:ok)
      end
    end

    context "when article doesn't exist" do
      it 'returns an error' do
        get "/articles/abc"

        expect(response).to have_http_status(:not_found)
      end
    end

  end
end
