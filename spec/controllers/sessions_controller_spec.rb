require 'rails_helper'

RSpec.describe SessionsController do
  describe "POST create" do
    before(:each) do
      @stub = stub_request(:post, "https://github.com/login/oauth/access_token")
      .with(
        body: { "client_id" => subject.send(:github_credentials)[:client_id],
          "client_secret"=> subject.send(:github_credentials)[:client_secret],
          "code"=> nil
        },
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>'Faraday v0.15.4'
        })
        .to_return(status: 299, body: { access_token: 'custom_token'}.to_json, headers: {})
      end

        it 'sets session' do
          expect(subject).to receive(:set_session).with('custom_token')

          get :create
        end

        it 'redirects' do
          get :create

          expect(@stub).to have_been_requested
          expect(response).to redirect_to('/')
        end
      end
    end
