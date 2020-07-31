class UserSessionsController < ApplicationController
    layout "home"
    def new
        
    end

    def create
        @user=User.find_by(username:params[:username])
        if @user && @user.authenticate(params[:password])
            log_user_in(@user)
            # flash[:notice]="Welcome #{@user.full_name}, Login was succesful."
            redirect_to @user
        else
            flash[:notice]="Wrong credentials!"
            redirect_to login_user_path
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to root_path
    end

end