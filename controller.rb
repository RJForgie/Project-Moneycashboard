require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('./models/tag.rb')
require_relative('./models/transaction.rb')
require_relative('./models/merchant.rb')
also_reload('.models/*')


#HOMEPAGE route

get '/' do
  erb(:home)
end

#INDEX route

get '/transactions' do
  @transactions = Transaction.all()
  puts @transactions
  @total = Transaction.total()
  erb(:index)
end

#NEW route

get 'transactions/new' do
  @merchants = Merchant.all
  @tags = Tags.all
  erb(:new)
end

# SHOW route

get '/transactions/:id' do
  @transaction = Transaction.find(params[:id])
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:show)
end

#CREATE route

get '/transactions' do
  @transaction = Transaction.new(params)
  @transaction.save
  erb(:create)
end
