namespace :user do
  desc "Charge the user for the total withdrawal amounts of all his projects"
  task weekly_charge: :environment do
    WeeklyChargeJob.perform_now
  end

end
