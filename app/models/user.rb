class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :bookings

  def Super_Manager?
    self.role == "Super_Manager"
  end

  def Manager?
    self.role == "Manager"
  end

  def Client?
    self.role == "Client"
  end

  def Guest?
    self.role == "Guest"
  end
end
