desc "This task is called by the Heroku scheduler add-on and checks all of our events to see who to notify"
task :check_events do
    puts "Checking satellites and shit"
 #   Events.update_all
    # get iss position
    # find geo rectangle of the pass region
    # find all users that live in the pass region
    # IssEvent.notify_subscribers!
    puts "done."
end
