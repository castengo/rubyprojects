namespace :update_db do
  desc "Add account to users"
  task add_account_to_users: :environment do
    User.all.each do |user|
      if user.account.nil?
        user.account = Account.new
        user.save
      end
    end
  end

  desc "Add short_type to products"
  #add short type to products (only lip and eye)
  task add_short_type: :environment do
    Product.all.each do |product|
      if product.short_type.nil?
        if product.product_type.downcase.include?("eye")
          product.short_type = "eye"
        elsif product.product_type.downcase.include?("lip")
          product.short_type  = "lip"
        end
        product.save
      end
    end
  end
end
