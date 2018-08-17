class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  
  def stock_already_added?(ticker_symbol)
    stock = Stock.find_by_ticker(ticker_symbol)
    
    # return false if stock doesn't exist in the Stock table
    return false unless stock
    
    # return if the stock belongs to the user
    user_stocks.where(stock_id: stock.id).exists?
  end
  
  
  def within_stock_limit?
    (user_stocks.count < 10)
  end
  
  
  def can_add_stock?(ticker_symbol)
    within_stock_limit? && !stock_already_added?(ticker_symbol)
  end
  
end
