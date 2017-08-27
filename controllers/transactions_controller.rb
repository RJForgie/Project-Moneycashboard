require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/accountsettings.rb')
# also_reload('.models/*')


#INDEX route

get '/transactions' do
  @transactions = Transaction.all()
  @total = Transaction.total()
  @tags = Tag.all()
  @merchants = Merchant.all()
  @accountsettings = AccountSettings.find(1)
  @january = Transaction.total_by_month(1)
  @february = Transaction.total_by_month(2)
  @march = Transaction.total_by_month(3)
  @april = Transaction.total_by_month(4)
  @may = Transaction.total_by_month(5)
  @june = Transaction.total_by_month(6)
  @july = Transaction.total_by_month(7)
  @august = Transaction.total_by_month(8)
  @september = Transaction.total_by_month(9)
  @october = Transaction.total_by_month(10)
  @november = Transaction.total_by_month(11)
  @december = Transaction.total_by_month(12)
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
