require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/accountsettings.rb')
require_relative('../models/month.rb')
also_reload("..models/*")


#INDEX route

get '/transactions' do
  @transactions = Transaction.all()
  @total = Transaction.total()
  @tags = Tag.all()
  @merchants = Merchant.all()
  @accountsettings = AccountSettings.find(1)
  @months = Month.total_by_month
  erb(:"transactions/index")
end

#NEW route

get '/transactions/new' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/new")
end

#SHOW route

get '/transactions/:id' do
  @transaction = Transaction.find( params[:id] )
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:"transactions/show")
end

#CREATE route

post '/transactions' do
  @transaction = Transaction.new(params)
  @transaction.save()
  erb(:"transactions/create")
end

#DELETE route
post '/transactions/:id/delete' do
  Transaction.delete(params[:id])
  redirect to "/transactions"
end

#EDIT route
get '/transactions/:id/edit' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  @transaction = Transaction.find(params[:id])
  erb(:"transactions/edit")
end

#UPDATE route
post '/transactions/:id' do
  transaction = Transaction.new(params)
  transaction.update()
  redirect to "/transactions/#{params['id']}"
end
