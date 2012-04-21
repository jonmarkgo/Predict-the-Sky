require 'spec_helper'

describe Subscriber do

  describe '#within' do
    subject { Subscriber.within(42, -72) }
    let(:subscriber) { FactoryGirl.create(:subscriber, latitude: 42, longitude: -72) }

    it "should return the subscriber" do
      should =~ [subscriber]
    end
  end
end
