class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :current_tutor

    def log_user_in(user)
        session[:user_id]=user.id
    end

    def log_tutor_in(tutor)
        session[:tutor_id]=tutor.id
    end

    def current_user
        @user=User.find_by(id:session[:user_id])
    end
    def current_tutor
        @tutor=Tutor.find_by(id:session[:tutor_id])
    end
end
