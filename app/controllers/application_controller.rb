class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    private
    def record_not_found
        render plain: 'Record not found', statuc: 404
    end
end
