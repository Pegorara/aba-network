class CompaniesController < ApplicationController
  def index
    @companies = policy_scope(Company)

    render json: @companies.map { |company| CompanySerializer.call(company) }
  end

  def show
    authorize Company
    
    render json: CompanySerializer.call(company)
  end

  def create
    authorize Company, :create?
    @company = Company.create(permitted_attributes(Company))

    render json: CompanySerializer.call(company), status: :created
  end

  def update
    authorize Company
    company.update!(permitted_attributes(Company))  
    
    render json: CompanySerializer.call(company), status: :ok
  end

  def destroy
    authorize Company
    company.destroy!

    head :no_content
  end

  private

  def company
    @company ||= Company.find(params[:id])
  end
end
