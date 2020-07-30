class UsersController < ApplicationController
    before_action :find_user_id, only:[:show,:edit,:update,:destroy]
    before_action :cities_states

    def new
        @user=User.new
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

    def edit
        @city=City.find_by(id:@user.city_id) 
    end

    def show         

    end

    def update
        @user.update(user_params)
        if @user.save
            redirect_to @user
        else
            render :edit
        end
    end

    private 
    def find_user_id
        @user=User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username,:password,:password_confirmation,:first_name,:last_name,:age,:occupation,:grade,:address,:photo,city_id:[:name,:state])
    end

    def cities_states
        @cities=CS.states(:us).keys.flat_map { |state| CS.cities(state, :us) }.uniq
        @states=CS.states(:us).values
    end
end
