require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/accountsettings.rb')
# also_reload('.models/*')

#INDEX route

get '/merchants/create' do
  @merchants = Merchant.all()
  erb(:"merchants/create")
end

#CREATE route

post '/merchants/create' do
  @merchant = Merchant.new(params)
  @merchant.save()
  redirect to :"/merchants/create"
end
