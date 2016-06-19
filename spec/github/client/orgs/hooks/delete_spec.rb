# encoding: utf-8

require 'spec_helper'

describe Github::Client::Orgs::Hooks, '#delete' do
  let(:org) { 'API-sampler' }
  let(:hook_id) { 1 }
  let(:request_path) { "/orgs/#{org}/hooks/#{hook_id}" }

  before {
    stub_delete(request_path).to_return(:body => body, :status => status,
      :headers => {:content_type => "application/json; charset=utf-8"})
  }

  after { reset_authentication_for(subject) }

  context "resource removed successfully" do
    let(:body) { '' }
    let(:status) { 204 }

    it "should fail to delete without 'org' parameter" do
      expect { subject.delete }.to raise_error(ArgumentError)
    end

    it "should fail to delete resource without 'hook_id'" do
      expect { subject.delete org }.to raise_error(ArgumentError)
    end

    it "should delete the resource" do
      subject.delete org, hook_id
      a_delete(request_path).should have_been_made
    end
  end

  it_should_behave_like 'request failure' do
    let(:requestable) { subject.delete org, hook_id }
  end
end # delete
