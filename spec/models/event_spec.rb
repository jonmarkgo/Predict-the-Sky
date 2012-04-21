require 'spec_helper'

describe IssEvent do

  describe "get_subscribers" do
    let(:event) { FactoryGirl.create(:event) }
    let(:subscriber1) { FactoryGirl.create(:subscriber) }
    let(:subscriber2) { FactoryGirl.create(:subscriber, phonenumber: "5555555555") }

    before do
      event

    end

    it "should return the correct subscribers" do

    end
  end
end
