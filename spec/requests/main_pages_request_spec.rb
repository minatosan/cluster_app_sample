require 'rails_helper'

RSpec.describe "MainPages", type: :request do
  it "response success" do
    get root_path
    expect(response.status).to eq(200)
  end
end
