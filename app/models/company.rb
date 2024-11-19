class Company < ApplicationRecord
  has_many :company_domains
  has_many :domains, through: :company_domains
  has_many :users


  validates :name, presence: true, length: { maximum: 250 }
  validates :cnpj, presence: true, length: { is: 14 }, uniqueness: true
end
