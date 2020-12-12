# Zen Pen
[Demo](https://www.youtube.com/watch?v=E7Rskdz5tn8)

LearnConnect is a platform that connects learners to volunteer instructors;

![LearnConnect](https://i.ibb.co/sywL0jz/Screen-Shot-2020-12-12-at-2-57-19-PM.png)
![LearnConnect](https://i.ibb.co/F7hfbj2/Screen-Shot-2020-12-12-at-2-57-56-PM.png)

Users can:
- Search for tutors in their area or other cities
- Filter by different attributes, such as subject.
- Manage their tutoring sessions

## Table of Contents
* [Getting Started](#getting-started)
* [Features](#features)
* [Tech Stack](#tech-stack)

<a name="getting-started"/>

## Getting Started

* Install [Homebrew](https://brew.sh/) 

  `$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
* Install [Ruby](https://www.ruby-lang.org/en/) 

  `$ brew install ruby` 
* Install [Rails](https://rubyonrails.org/) 

  `$ gem install rails`

# Download This Project

* Clone the repo and cd into the directory
* Install dependencies

  `$ bundle install`
* Migrate and seed

  `$ rails db:migrate`  

  `$ rails db:seed`
* Start rails server

  `$ rails s`  

<a name="features"/>

## Features

### Tutors Portal
![Tutors Portal](https://i.ibb.co/F7hfbj2/Screen-Shot-2020-12-12-at-2-57-56-PM.png)

* Find a volunteering tutor
* See all tutors in your area

### Filter Tutors
![Filter](https://i.ibb.co/6bdtJYx/Screen-Shot-2020-12-12-at-3-11-25-PM.png)

* Filter tutors by different attributes

### Schedule Session
![Schedule](https://i.ibb.co/gV7b8xd/Screen-Shot-2020-12-12-at-2-58-57-PM.png)

* Schedule a tutoring session
* Schedule up to a week in advance

### Manage Sessions
![Manage](https://i.ibb.co/w0Xt5yT/Screen-Shot-2020-12-12-at-2-59-51-PM.png)
![Manage](https://i.ibb.co/mXvVD6f/Screen-Shot-2020-12-12-at-3-03-32-PM.png)

* Manage tutoring sessions from the tutor page
* Manage tutoring sessions from the learner page

### Auth
![Auth](https://i.ibb.co/sqgxmdm/Screen-Shot-2020-12-12-at-3-00-29-PM.png)

* Register and login, edit and delete account

<a name="tech-stack"/>

# Tech Stack
* Ruby on Rails
* PostgreSQL
* HTML/SCSS
* Active Record
