require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('./models/tag.rb')
require_relative('./models/transaction.rb')
require_relative('./models/merchant.rb')
# also_reload('.models/*')



#HOMEPAGE route

get '/' do
  erb(:home)
end

#INDEX route

get '/transactions' do
  @transactions = Transaction.all()
  puts @transactions
  @total = Transaction.total()
  @april = Transaction.total_by_month(4)

  erb(:index)
end

#NEW route

get '/transactions/new' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:new)
end

#SHOW route

get '/transactions/:id' do
  @transaction = Transaction.find(params[:id])
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:show)
end

#CREATE route

post '/transactions' do
  @transaction = Transaction.new(params)
  @transaction.save()
  erb(:create)
end

#DELETE route
post '/transactions/:id/delete' do
  Transaction.delete(params[:id])
  redirect to '/transactions'
end

#EDIT route
get '/transactions/:id/edit' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  @transaction = Transaction.find(params[:id])
  erb(:edit)
end

#UPDATE route
post '/transactions/:id' do
  transaction = Transaction.new(params)
  transaction.update()
  redirect to "/transactions/#{params[:id]}"
end
