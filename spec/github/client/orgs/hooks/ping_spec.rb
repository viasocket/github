# encoding: utf-8

require 'spec_helper'

describe Github::Client::Orgs::Hooks, '#ping' do
  let(:org) { 'API-sampler' }
  let(:hook_id) { 1 }
  let(:request_path) { "/orgs/#{org}/hooks/#{hook_id}/pings" }

  before {
    stub_post(request_path).to_return(:body => body, :status => status,
      :headers => {:content_type => "application/json; charset=utf-8"})
  }

  after { reset_authentication_for(subject) }

  context "resource tested successfully" do
    let(:body) { '' }
    let(:status) { 204 }

    it "should fail to test without 'org' parameter" do
      expect { subject.ping }.to raise_error(ArgumentError)
    end

    it "should fail to test resource without 'hook_id'" do
      expect { subject.ping org }.to raise_error(ArgumentError)
    end

    it "should trigger test for the resource" do
      subject.ping org, hook_id
      a_post(request_path).should have_been_made
    end
  end

  it_should_behave_like 'request failure' do
    let(:requestable) { subject.ping org, hook_id }
  end
end # ping
