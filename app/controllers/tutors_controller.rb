class TutorsController < ApplicationController
    before_action :find_tutor_id, only:[:show,:edit,:update,:destroy]
    before_action :cities_states
    
    
        
    def index
        @tutors=Tutor.all
        
        if(params[:search].present?)
            the_state=params[:search][:state]
            the_city=params[:search][:city]
            all_subjects=params[:search][:subjects]

            if(!the_state.empty? && !the_city.empty? && !all_subjects.reject { |c| c.empty?}.empty?)
                all_states=City.where("state ILIKE ?", the_state)
                all_cities=all_states.where("name ILIKE ?", the_city)
                if all_cities.empty?
                    @tutors=nil
                else
                    @tutors=all_cities.first.tutors.select { |tutors| all_subjects.reject { |c| c.empty? }.all? { |str| tutors.subjects.downcase.include? str }}

                end    

            elsif(!the_state.empty? && !the_city.empty? && all_subjects.reject { |c| c.empty?}.empty?)
                all_states=City.where("state ILIKE ?", the_state)
                all_cities=all_states.where("name ILIKE ?", the_city)
                if(all_cities.empty?)
                    @tutors=nil
                else
                    @tutors=all_cities.first.tutors
                end
            elsif(!the_state.empty? && the_city.empty? && !all_subjects.reject { |c| c.empty?}.empty?)
                all_states=City.where("state ILIKE ?", the_state)
                @tutors=all_states.map{|state| state.tutors.select { |tutors| all_subjects.reject { |c| c.empty? }.all? { |str| tutors.subjects.downcase.include? str }}}.flatten.compact
                
            elsif(the_state.empty? && !the_city.empty? && !all_subjects.reject { |c| c.empty?}.empty?)
                all_cities=City.where("name ILIKE ?", the_city)
                @tutors=all_cities.map{|city| city.tutors.select { |tutors| all_subjects.reject { |c| c.empty? }.all? { |str| tutors.subjects.downcase.include? str }}}.flatten.compact
                
            elsif(!the_state.empty? && the_city.empty? && all_subjects.reject { |c| c.empty?}.empty?)
                all_states=City.where("state ILIKE ?", the_state)
                @tutors=all_states.map{|state|state.tutors}.flatten
                

                
            elsif(the_state.empty? && !the_city.empty? && all_subjects.reject { |c| c.empty?}.empty?)
                all_cities=City.where("name ILIKE ?", the_city)
                @tutors=all_cities.map{|city|city.tutors}.flatten
                
            elsif(the_state.empty? && the_city.empty? && !all_subjects.reject { |c| c.empty?}.empty?) 
                @tutors=Tutor.select { |tutors| all_subjects.reject { |c| c.empty? }.all? { |str| tutors.subjects.downcase.include? str }}
            else
                @tutors=Tutor.all
                
            end
        end
      
    end

    def new
        @tutor=Tutor.new
        @errors=flash[:errors]
    end

    def create

        # def check_city
        #     state=CS.states(:us).key(self.state)
        #     cities=CS.cities(state, :us)
        # if(cities.include?(self.name))
        #     return true
        # else
        #     return false
        # end
        # end

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
        params.require(:tutor).permit(:username,:password,:password_confirmation,:first_name,:last_name,:age,:education_level,:subjects,:address,:photo,city_id:[:name,:state])
    end

    def cities_states
        @cities=CS.states(:us).keys.flat_map { |state| CS.cities(state, :us) }.uniq
        @states=CS.states(:us).values
    end

end
