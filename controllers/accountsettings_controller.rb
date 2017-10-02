require('sinatra')
# require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/accountsettings.rb')

#INDEX route

get '/accountsettings/:id/edit' do
  @accountsettings = AccountSettings.find(params[:id])
  erb(:"accountsettings/edit")
end

#UPDATE route
post '/accountsettings/:id' do
  accountsetting = AccountSettings.new(params)
  accountsetting.update()
  redirect to :"/accountsettings/#{params[:id]}/edit"
end
