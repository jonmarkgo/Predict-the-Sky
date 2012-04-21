require File.expand_path('../../../config/environment', __FILE__)
require File.expand_path('../../../app/models/iss_position', __FILE__)
require File.expand_path('../../../app/models/subscriber', __FILE__)

desc "This task is called by the Heroku scheduler add-on and checks all of our events to see who to notify"
task :check_events do
  puts "Checking satellites and shit"

  # get iss position
  position = IssPosition.new

  # find all users that live in the pass region
  subscribers = Subscriber.all #within(position.latitude, position.longitude)
  puts "Found #{subscribers.count} subscribers"

  if subscribers.count > 0
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    subscribers.each do |subscriber|
      @client.account.sms.messages.create(
        :from => '+12014256272',
        :to => subscriber.phonenumber,
        :body => 'The Internation Space Station will pass overhead soon, go outside and check it out! NOW!'
      )
    end
  end
  puts "done."
end
