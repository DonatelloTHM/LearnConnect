class TutorSessionsController < ApplicationController

    def new

    end

    def create
        @tutor=Tutor.find_by(username:params[:username])
        if @tutor && @tutor.authenticate(params[:password])
            log_tutor_in(@tutor)
            flash[:notice]="Welcome #{@tutor.full_name}, Login was succesful."
            redirect_to @tutor
        else
            flash[:notice]="Wrong credentials!"
            redirect_to login_tutor
        end
    end

    def destroy
        session[:tutor_id] = nil
        flash[:notice] = "Logged out!"
        redirect_to root_path
    end

    
end