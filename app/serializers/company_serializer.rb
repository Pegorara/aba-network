class CompanySerializer < ApplicationSerializer
  def self.call(company)
    base_data = {
      cnpj: company.cnpj,
      name: company.name
    }

    base_data.merge(serialize_timestamps(company))
  end
end
