class User < ApplicationRecord
  has_many :decks, dependent: :destroy

  # Others available are: :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
end
