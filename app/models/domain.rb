class Domain < ApplicationRecord
  has_many :company_domains, dependent: :destroy
  has_many :companies, through: :company_domains

  validates :domain_url, presence: true, uniqueness: true
end
