class StoreController < ApplicationController
  before_action :count, only: [:index]

  include CurrentCart
  before_action :set_cart
  
  def index
    @accesses = session[:count]
    @products = Product.order(:title)
  end

  private
    def count
      if session[:count].nil?
        session[:count] = 1
      else
        session[:count] += 1
      end
    end
end
