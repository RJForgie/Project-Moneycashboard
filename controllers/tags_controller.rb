require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/accountsettings.rb')
# also_reload('.models/*')

#INDEX route

get '/tags' do
  @tags = Tag.all()
  erb(:"tags/index")
end

#CREATE route

post '/tags' do
  @tag = Tag.new(params)
  @tag.save()
  redirect to "/tags"
end
