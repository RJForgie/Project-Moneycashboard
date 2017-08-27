require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/accountsettings.rb')
# also_reload('.models/*')

#INDEX route

get '/merchants' do
  @merchants = Merchant.all()
  erb(:"merchants/index")
end

#CREATE route

post '/merchants' do
  @merchant = Merchant.new(params)
  @merchant.save()
  redirect to "/merchants"
end
