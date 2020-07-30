class UsersController < ApplicationController
    before_action :find_user_id, only:[:show,:edit,:update,:destroy]

    def new
        @user=User.new
        @cities=CS.states(:us).keys.flat_map { |state| CS.cities(state, :us) }.uniq
        @states=CS.states(:us).values
        @errors=flash[:errors]
    end

    def create
        @user=User.new(user_params)
        if @user.save
            log_user_in(@user)
            redirect_to @user
        else
            flash[:errors]=@user.errors.full_messages
            redirect_to new_user_path
        end
    end

    def show         

    end

    private 
    def find_user_id
        @user=User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username,:password,:password_confirmation,:first_name,:last_name,:age,:occupation,:grade,:address,:photo,city_id:[:name,:state])
    end
end
