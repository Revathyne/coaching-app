# Coaching App

This app is to streamline a companies group coaching programs for employees. These coaching programs encompass various leadership and training initiatives tailored to enhance employee development and performance. To efficiently manage these
programs, the company seeks to implement a robust administration panel.

## Setup

1. Clone the repository
2. Run `bundle install` to install all necessary gems
3. Run `yarn install`
4. Run `rails generate devise:install` to generate the user sessions
5. Run `rails generate devise User`
6. Run `rails generate rails_admin:install` to create the admin panel
7. Set up the database: `rails db:create db:migrate`
8. Run `rails db:seed` to create an admin user
9. Start the server: `rails server`
10. Access the application at `http://localhost:3000`

## Features Of the Application

This Application consists of a User with three different roles(Admin, Employee, Coach), companies and its coaching programs including different coaches for each coaching program. These coaching programs are registered by employee.
The application also has user sessions.

The User with the employee role is attached to a Company.
The company has many coaching programs attached to it.
The Coach has many coahing programs and employee registrations registering for the coaching program.
The coaching program belongs to a company and has many employee registrations and coaches.
The employee registration belongs to a coaching program and also a coach attached to it.

## The application has:

The admin who has access to all areas of the applications. That is:
- Administration panel:
  - creating and managing companies, coaching programs, and coaches
  - Assigning multiple company programs to a coach
  - Custom subtab under the company to list registered employees
  - Landing page for each company displaying basic information

Next one is the Employee. Each employee is associated to a company. The employer can register for different coaching sessions provided by selecting the coaches using a registration form.
- Employee Registration Process:
  - A dashboard page to show the employees company and registered coaching programs
  - Employee registration process with a form wizard

The user with coach role is the one who takes coaching sessions for the employees. The coaches are associated to coaching programs 
- Coach Dashboard:
  - Coach dashboard displaying coaching sessions enrolled by employees
  - Dynamic filtering options to sort sessions based on company program name and company name.
  - A section highlighting companies for which the coach has coaching responsibilities



## Test Run
To run test cases Run `bundle exec rspec`
