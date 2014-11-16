class HatsController < ApplicationController

  def index
    @hats = Hat.all
    render 'index'
  end

  def new
  end

  def show
    id = params[:id]
    @hat = Hat.find_by_id(id)

    if @hat != nil then
      render 'hats/show'      
    else
      head(404)
      return nil
    end
  end

  def update
    h = params[:hat]
    id = params[:id].to_i

    if h != nil then
      hat = Hat.find_by_id(id)

      if hat == nil then
        head(404)
        return nil
      end

      hat.update(h)

      if hat != nil then 
        redirect_to ({:action => :show, :id => hat.id })
      else
        head(404)
        return nil
      end
    else
      head(404)
      return nil
    end
  end

  def destroy
    id = params[:id].to_i
    h = Hat.find_by_id(id)
    
    if h == nil then
      head(404)
      return nil
    else
      Hat.delete(id)
      redirect_to '/'
    end
  end

  def edit
    id = params[:id]
    @hat = Hat.find_by_id(id.to_i)

    if @hat != nil then
      render 'hats/edit' 
    else
      head(404)
      return nil
    end
  end

  def create
    h = params[:hat]
    hat = Hat.create({:name => h["name"], :size => h["size"].to_i})
     
    redirect_to ({:action => :show, :id => hat.id })
  end

end
