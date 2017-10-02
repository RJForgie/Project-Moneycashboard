require('sinatra')
require('sinatra/contrib/all') if development?
# require('pry-byebug')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/accountsettings.rb')
# also_reload('.models/*')

#INDEX route

get '/tags/new' do
  @tags = Tag.all()
  erb(:"tags/new")
end

#NEW route

post '/tags/new' do
  tags = Tag.names
  @tag = Tag.new(params)
  @tag.save() unless tags.include? @tag.name
  redirect to "/tags/new"
end
