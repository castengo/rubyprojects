namespace :update_db do
  desc "TODO"
  task add_account_to_users: :environment do
    User.all.each do |user|
      if user.account.nil?
        user.account = Account.new
        user.save
      end
    end
  end
end
