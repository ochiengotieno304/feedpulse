# frozen_string_literal: true

RSpec.describe 'GET /news', type: %i[request database] do
  let(:news) { app['persistence.rom'].relations[:news] }

  before do
    news.insert(title: 'title one', snippet: 'snippet one', url: 'url one', source: 'source one', code: 'code one')
    news.insert(title: 'title two', snippet: 'snippet two', url: 'url two', source: 'source two', code: 'code two')
    news.insert(title: 'title three', snippet: 'snippet three', url: 'url three', source: 'source three',
                code: 'code three')
  end

  it 'returns a list of news' do
    get '/news'

    expect(last_response).to be_successful
    expect(last_response.content_type).to eq('application/json; charset=utf-8')

    response_body = JSON.parse(last_response.body)

    expect(response_body).to eq([
                                  { 'title' => 'title one', 'snippet' => 'snippet one', 'url' => 'url one',
                                    'source' => 'source one', 'code' => 'code one' },
                                  { 'title' => 'title two', 'snippet' => 'snippet two', 'url' => 'url two',
                                    'source' => 'source two', 'code' => 'code two' },
                                  { 'title' => 'title three', 'snippet' => 'snippet three', 'url' => 'url three',
                                    'source' => 'source three', 'code' => 'code three' }
                                ])
  end
end
