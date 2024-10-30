class DomainsController < ApplicationController
  def index
    @domains = policy_scope(Domain)
    render json: @domains
  end

  def show
    authorize domain
    render json: domain
  end

  private
  def domain
    @domain ||= Domain.find(params[:id])
  end
end
