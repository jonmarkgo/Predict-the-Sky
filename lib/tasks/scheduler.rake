desc "This task is called by the Heroku scheduler add-on and checks all of our events to see who to notify"
task :check_events do
    puts "Checking satellites and shit"
 #   Events.update_all
    # get iss position
    position = IssPosition.new
    # find all users that live in the pass region
    subscribers = Subscriber.within(position.latitude, position.longitude)
    # IssEvent.notify_subscribers!
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    subscribers.each do |subscriber|
        @client.account.sms.messages.create(
          :from => '+12014256272',
          :to => subscriber.phonenumber,
          :body => 'The Internation Space Station will pass overhead soon, go outside and check it out! NOW!'
        )
    end
    puts "done."
end
