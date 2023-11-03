class PromptsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:search]

    def index
    end

    def search
      Rails.logger.info "aaaaaaaaaaaaaaa #{params[:q]}"  

      if params[:q].present?
        data = Prompt.search(params[:q]).records.to_a
      else
        data = []
      end

      render json: { data: data } 
    end
end