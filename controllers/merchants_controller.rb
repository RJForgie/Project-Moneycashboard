require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/accountsettings.rb')
# also_reload('.models/*')

#INDEX route

get '/merchants/new' do
  @merchants = Merchant.all()
  erb(:"merchants/new")
end

#NEW route

post '/merchants/new' do
  @merchant = Merchant.new(params)
  @merchant.save()
  redirect to :"/merchants/new"
end
