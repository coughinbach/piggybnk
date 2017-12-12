class WeeklyChargeJob < ApplicationJob
  queue_as :default

  def perform
    if Date.today.sunday?
      #itérer sur chaque user qui a renseigné sa CC
      User.where.not(stripe_customer_id: nil).each do |user|
      #   total_withdrawal = 0
      # #itérer sur chaque projet du user qui est actif
      #   user.user_projects.each do |user_project|
      #     #calcul de la somme totale de withdrawal sur tous ses projets
      #     total_withdrawal += user_project.withdrawal_amount_total_cents if user_project.project.status == "Active"
      #   end
      # following line is equivalent to commented lines above -- SQL is faster than an each
      total_withdrawal_cents = user.user_projects.joins(:project).where(projects: { status: "Active" }).sum("withdrawal_amount_total_cents + total_weekly_withdrawal_cents")
        #charge la somme totale de tous les withdrawals de ses projets actifs
        if total_withdrawal_cents > 0
          charge = Stripe::Charge.create(
            customer:     user.stripe_customer_id,
            amount:       total_withdrawal_cents,
            description:  "Payment for all your active projects.",
            currency:     "eur"
          )
        puts "Congrats! You have stuffed #{total_withdrawal_cents/100} € into your Piggy Bank."
        end
        user.user_projects.each do |user_project|
          user_project.update(total_weekly_withdrawal_cents: 0)
        end
      end
    end
  end
end
