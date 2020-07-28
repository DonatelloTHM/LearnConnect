class TutorsController < ApplicationController
    before_action :find_tutor_id, only:[:show,:edit,:update,:destroy]
    before_action :cities_states
    
    def new
        @tutor=Tutor.new
        @errors=flash[:errors]
    end

    def create
        @tutor=Tutor.create(tutor_params)
        if @tutor.valid?
            log_tutor_in(@tutor)
            redirect_to @tutor
        else
            flash[:errors]=@tutor.errors.full_messages
            redirect_to new_tutor_path
        end
    end

    def edit
       @city=City.find_by(id:@tutor.city_id) 
    end

    def show
        return head(:forbidden) unless @tutor == current_tutor
        
    end

    private
    def find_tutor_id
        @tutor=Tutor.find(params[:id])
    end

    def tutor_params
        params.require(:tutor).permit(:username,:password,:password_confirmation,:first_name,:last_name,:age,:education_level,:subject,:address,city_id:[:name,:state])
    end

    def cities_states
        @cities=CS.states(:us).keys.flat_map { |state| CS.cities(state, :us) }.uniq
        @states=CS.states(:us).values
    end

end
