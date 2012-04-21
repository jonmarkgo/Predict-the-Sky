require 'spec_helper'

describe IssPosition do
  subject { IssPosition.new }
  it "should retrun the positon of the ISS" do
    subject.latitude.should_not be_nil
    subject.longitude.should_not be_nil
  end
end
