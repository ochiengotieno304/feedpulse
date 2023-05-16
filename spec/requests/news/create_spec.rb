# spec/requests/news/create_spec.rb

RSpec.describe "POST /news", type: [:request, :database] do
  let(:request_headers) do
    { "HTTP_ACCEPT" => "application/json", "CONTENT_TYPE" => "application/json" }
  end

  context "given valid params" do
    let(:params) do
      { item: { title: "title 1", snippet: "snippet 1", url: "url 1", source: "source 1", code: "code 1" } }
    end

    it "creates a news item" do
      post "/news", params.to_json, request_headers

      expect(last_response).to be_created
    end
  end

  context "given invalid params" do
    let(:params) do
      { item: { title: nil } }
    end

    it "returns 422 unprocessable" do
      post "/news", params.to_json, request_headers

      expect(last_response).to be_unprocessable
    end
  end
end
