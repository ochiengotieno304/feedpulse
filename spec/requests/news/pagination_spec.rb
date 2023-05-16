RSpec.describe 'GET /news pagination', type: [:request, :database] do
  let(:news) { app['persistence.rom'].relations[:news] }

  before do
    10.times do |n|
      news.insert(title: "title #{n}", snippet: "snippet #{n}", url: "url #{n}", source: "source #{n}", code: "code #{n}")
    end
  end

  context 'given valid page and per_page params' do
    it 'returns the correct page of news' do
      get '/news?page=1&per_page=3'

      expect(last_response).to be_successful

      response_body = JSON.parse(last_response.body)

      expect(response_body).to eq([
                                    { 'title' => 'title 0', 'snippet' => 'snippet 0', 'url' => 'url 0', 'source' => 'source 0', 'code' => 'code 0' },
                                    { 'title' => 'title 1', 'snippet' => 'snippet 1', 'url' => 'url 1', 'source' => 'source 1', 'code' => 'code 1' },
                                    { 'title' => 'title 2', 'snippet' => 'snippet 2', 'url' => 'url 2', 'source' => 'source 2', 'code' => 'code 2' }])

    end

  end

  context 'given invalid page and per_page params' do
    it 'returns a 422 unprocessable response' do
      get '/news?page=-1&per_page=3000'

      expect(last_response).to be_unprocessable

      response_body = JSON.parse(last_response.body)

      expect(response_body).to eq(
        'errors' => {
          'page' => ['must be greater than 0'],
          'per_page' => ['must be less than or equal to 100']
        }
      )
    end
  end
end
