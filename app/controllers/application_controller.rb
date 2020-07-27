class ApplicationController < ActionController::Base


    def log_user_in(user)
        session[:user_id]=user_id
    end

    def log_tutor_in(tutor)
        session[:tutor_id]=tutor_id
    end
end
