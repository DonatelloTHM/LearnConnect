# frozen_string_literal: true

class TutorsController < ApplicationController
  before_action :find_tutor_id, only: %i[show edit update destroy my_page]
  before_action :cities_states

  def index
    @my_city_tutors = Tutor.select { |tutor| tutor.city == current_user.city }
    @tutors = Tutor.all
    if params[:search].present?
      the_state = params[:search][:state]
      the_city = params[:search][:city]
      all_subjects = params[:search][:subjects]

      flash[:state] = the_state
      flash[:city] = the_city
      flash[:subjects] = all_subjects

      if !the_state.empty? && !the_city.empty? && !all_subjects.reject(&:empty?).empty?
        all_states = City.where('state ILIKE ?', the_state)
        all_cities = all_states.where('name ILIKE ?', the_city)
        if all_cities.empty?
          @tutors = nil
        else
          @tutors = all_cities.first.tutors.select { |tutors| all_subjects.reject(&:empty?).all? { |str| tutors.subjects.downcase.include? str } }

        end

      elsif !the_state.empty? && !the_city.empty? && all_subjects.reject(&:empty?).empty?
        all_states = City.where('state ILIKE ?', the_state)
        all_cities = all_states.where('name ILIKE ?', the_city)
        @tutors = if all_cities.empty?
                    nil
                  else
                    all_cities.first.tutors
                  end
      elsif !the_state.empty? && the_city.empty? && !all_subjects.reject(&:empty?).empty?
        all_states = City.where('state ILIKE ?', the_state)
        @tutors = all_states.map { |state| state.tutors.select { |tutors| all_subjects.reject(&:empty?).all? { |str| tutors.subjects.downcase.include? str } } }.flatten.compact

      elsif the_state.empty? && !the_city.empty? && !all_subjects.reject(&:empty?).empty?
        all_cities = City.where('name ILIKE ?', the_city)
        @tutors = all_cities.map { |city| city.tutors.select { |tutors| all_subjects.reject(&:empty?).all? { |str| tutors.subjects.downcase.include? str } } }.flatten.compact

      elsif !the_state.empty? && the_city.empty? && all_subjects.reject(&:empty?).empty?
        all_states = City.where('state ILIKE ?', the_state)
        @tutors = all_states.map(&:tutors).flatten

      elsif the_state.empty? && !the_city.empty? && all_subjects.reject(&:empty?).empty?
        all_cities = City.where('name ILIKE ?', the_city)
        @tutors = all_cities.map(&:tutors).flatten

      elsif the_state.empty? && the_city.empty? && !all_subjects.reject(&:empty?).empty?
        @tutors = Tutor.select { |tutors| all_subjects.reject(&:empty?).all? { |str| tutors.subjects.downcase.include? str } }
      else
        @tutors = Tutor.all

      end
    end
  end

  def new
    @tutor = Tutor.new
    @errors = flash[:errors]
  end

  def create
    @tutor = Tutor.create(tutor_params)
    if @tutor.valid?
      log_tutor_in(@tutor)
      redirect_to my_page_path(@tutor)
    else
      flash[:errors] = @tutor.errors.full_messages
      redirect_to new_tutor_path
    end
  end

  def schedule_session
    @tutoring_session = TutoringSession.create(tutoring_session_params)
    redirect_back(fallback_location: current_user)
  end

  def cancel_session
    @tutoring_session = TutoringSession.find(params[:tutoring_session_id])
    if params[:by_tutor]
      session[:notification] << [@tutoring_session.user_id, "#{@tutoring_session.tutor.full_name} canceled your reservation for #{@tutoring_session.start_time.utc.strftime('%H:%M')} "]
    end
    @tutoring_session.destroy
    redirect_back(fallback_location: current_user)
  end

  def edit
    @city = City.find_by(id: @tutor.city_id)
    @errors = flash[:errors]
  end

  def show
    # return head(:forbidden) unless @tutor == current_tutor
  end

  def update
    @tutor.update(tutor_params)
    if @tutor.save
      redirect_to @tutor
    else
      render :edit
    end
  end

  def my_page; end

  def make_available
    @tutoring_session = TutoringSession.find(params[:tutoring_session_id])
    @tutoring_session.destroy
    redirect_to my_page_path(current_tutor)
  end

  def make_unavailable
    # @tutoring_session=TutoringSession.create(tutoring_session_params)
    @tutoring_session = TutoringSession.create(start_time: params[:tutoring_sessions][:start_time], tutor_id: params[:tutoring_sessions][:tutor_id], duration: params[:tutoring_sessions][:duration])
    redirect_to my_page_path(current_tutor)
  end

  private

  def find_tutor_id
    @tutor = Tutor.find(params[:id])
  end

  def tutor_params
    params.require(:tutor).permit(:username, :password, :password_confirmation, :first_name, :last_name, :age, :education_level, :subjects, :address, :photo, city_id: %i[name state])
  end

  def cities_states
    @cities = CS.states(:us).keys.flat_map { |state| CS.cities(state, :us) }.uniq
    @states = CS.states(:us).values
  end

  def tutoring_session_params
    params.require(:tutoring_sessions).permit(:user_id, :tutor_id, :start_time, :duration)
  end
end
