class TutorSessionsController < ApplicationController
    layout "home"
    def new

    end

    def create
        @tutor=Tutor.find_by(username:params[:username])
        if @tutor && @tutor.authenticate(params[:password])
            log_tutor_in(@tutor)
            if(!session[:notification])
            session[:notification]=[]
            end
            # flash[:notice]="Welcome #{@tutor.full_name}, Login was succesful."
            redirect_to my_page_path(@tutor)
        else
            flash[:notice]="Wrong credentials!"
            redirect_to login_tutor_path
        end
    end

    def destroy
        session[:tutor_id] = nil
        redirect_to root_path
    end

    
end