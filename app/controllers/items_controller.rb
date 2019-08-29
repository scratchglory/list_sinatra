class ItemsController < ApplicationController
  # To read all items
  get '/items' do
    @items = Item.where(user_id: session[:user_id])
    erb :'items/index'
  end

  # creating a new item
  get '/items/new' do
    erb :'items/new'
  end

  # Read the list, job not to display to user (only do something)
  post '/items' do
    @item = Item.create(params)
    @item.user_id = session[:user_id]
    # Needs to be saved for user_id
    @item.save
    redirect "/items/#{@item.id}"
  end

  # To show individual item
  get '/items/:id' do
    @item = Item.find(params[:id])
    erb :'items/show'
  end

  get '/items/edit' do
    @items = Item.where(user_id: session[:user_id])
    erb :'items/list'
  end

  get '/items/:id/edit' do
    @item = Item.find(params[:id])
    erb :'items/edit'
  end

  # Edit an item
  patch '/items/:id' do
    @item = Item.find(params[:id])
    @item.update(name: params[:name], quantity: params[:quantity])
    redirect "/items/#{@item.id}"
  end

  # Delete an item
  delete '/items/:id' do
    @item = Item.find(params[:id])
    @item.destroy

    redirect '/users/home'
  end
end
