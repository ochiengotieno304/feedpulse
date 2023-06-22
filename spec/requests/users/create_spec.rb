# frozen_string_literal: true

RSpec.describe 'POST /api/auth/signup', type: %i[request database] do
  let(:request_headers) do
    { 'HTTP_ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json' }
  end

  context 'given valid params' do
    let(:params) do
      { user: { username: 'test', email: 'test@mail.com' } }
    end

    it 'creates a new user' do
      post '/api/auth/signup', params.to_json, request_headers

      expect(last_response).to be_created
    end
  end

  context 'given invalid params' do
    let(:params) do
      { user: { username: nil } }
    end

    it 'returns 422 unprocessable' do
      post '/api/auth/signup', params.to_json, request_headers

      expect(last_response).to be_unprocessable
    end
  end
end
