module Api
  module V1
    class CompaniesController < ApiController
      load_and_authorize_resource
      before_action :set_company, only: %i[show update destroy]

      def index
        @companies = Company.accessible_by(current_ability) # it is a method from cancan
        # @companies = current_user.companies
        render json: { data: @companies, status: :ok }
      end

      def show
        render json: @company, status: :ok
      end

      def create
        @company = Company.new(company_params)
        # @company = current_user.companies.new(company_params)
        if @company.save
          render json: { data: @company, message: 'Company created successfully.' }, status: :ok
        else
          render json: { status: 'failed', data: @company.errors.full_messages }, status: :unprocessable_content
        end
      end

      def update
        if @company.update(company_params)
          render json: { data: @company, message: 'Company updated successfully.'}, status: :ok
        else
          render json: { status: 'failed', data: @company.errors.full_messages }, status: :unprocessable_content
        end
      end

      def destroy
        if @company.destroy
          render json: { status: :ok, message: 'Company deleted successfully.' }
        else
          render json: { message: 'Something went wrong', status: 'failed' }
        end
      end

      private

      def set_company
        @company = Company.find(params[:id])
        # @company = current_user.companies.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { message: e.message, status: :unauthorized }
      end

      def company_params
        params.require(:company).permit(:name, :address, :established_year, :user_id)
      end
    end
  end
end