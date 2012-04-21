require 'spec_helper'

describe IssEvent do

  describe "get_subscribers" do
    let(:event) { FactoryGirl.create(:iss_event) }
    let(:subscriber1) { FactoryGirl.create(:subscriber) }
    let(:subscriber2) { FactoryGirl.create(:subscriber, phonenumber: "5555555555") }

    before do
      event.subscribers << subscriber1
    end

    it "should return the correct subscribers" do
      event.subscribers.should =~ [subscriber1]
    end
  end
end
