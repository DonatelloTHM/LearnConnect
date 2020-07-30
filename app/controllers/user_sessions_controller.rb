class UserSessionsController < ApplicationController

    def new
        
    end

    def create
        @user=User.find_by(username:params[:username])
        if @user && @user.authenticate(params[:password])
            log_user_in(@user)
            flash[:notice]="Welcome #{@user.full_name}, Login was succesful."
            redirect_to @user
        else
            flash[:notice]="Wrong credentials!"
            redirect_to login_user
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Logged out!"
        redirect_to root_path
    end

end