class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  
  before_save {
    self.email = email.downcase
  }
  
  # get user's full name
  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end
  
  # determine if user already follows a given stock
  def stock_already_added?(ticker_symbol)
    stock = Stock.find_by_ticker(ticker_symbol)
    
    # return false if stock doesn't exist in the Stock table
    return false unless stock
    
    # return if the stock belongs to the user
    user_stocks.where(stock_id: stock.id).exists?
  end
  
  # determine if user follows less than 10 stocks
  def within_stock_limit?
    (user_stocks.count < 10)
  end
  
  # determine if a user can follow a given stock
  def can_add_stock?(ticker_symbol)
    within_stock_limit? && !stock_already_added?(ticker_symbol)
  end
  
end
