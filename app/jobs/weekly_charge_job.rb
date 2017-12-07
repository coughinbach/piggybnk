class WeeklyChargeJob < ApplicationJob
  queue_as :default

  def perform
    total_withdrawal = 0
    #itérer sur chaque user
    User.all.each do |user|
    #itérer sur chaque projet du user qui est actif
      user.user_projects.each do |user_project|
        #calcul de la somme totale de withdrawal sur tous ses projets
        total_withdrawal += user_project.withdrawal_amount_total_cents if user_project.project.status == "Active"
      end
      #charge la somme totale de tous les withdrawals de ses projets actifs
      if total_withdrawal > 0
        charge = Stripe::Charge.create(
          customer:     user.stripe_customer_id,
          amount:       total_withdrawal,
          description:  "Payment for all your active projects.",
          currency:     "eur"
        )
        puts "charged #{total_withdrawal} euros from #{user}"
      end
    end
  end
end
