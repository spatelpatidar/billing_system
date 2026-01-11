Billing System – Ruby on Rails Mini Project
Overview

This is a Billing System implemented using Ruby on Rails as part of the RoR Task Round.
The application allows managing products, generating customer bills, calculating taxes, handling cash denominations, sending invoices via email asynchronously, and viewing previous customer purchases.

The project follows Rails best practices, clean MVC separation, and production-ready conventions.

Tech Stack

Ruby: 3.2.2

Rails: 7.1.6

Database: PostgreSQL (Recommended)

Background Jobs: ActiveJob

Email: ActionMailer (SMTP)

Note: SQLite can be used with minor configuration changes if PostgreSQL is unavailable.

Dependency Management (Important Note)

This project is implemented using Ruby on Rails, as required for the RoR task round.

The original task description mentions requirements.txt, which is applicable only for Python/Django projects.
In Ruby on Rails applications, dependencies are managed using Bundler.

Ruby on Rails Dependency Management

All project dependencies are defined in the Gemfile

Exact locked versions are recorded in Gemfile.lock

To install all dependencies, run:

bundle install

Prerequisites

Ensure the following are installed on your system:

Ruby 3.2.2

Rails 7.1.6 or later

PostgreSQL

Bundler

Environment Configuration

This application uses environment variables for database and email configuration.

Create a .env file in the project root directory and add the following variables:

DATABASE_URL=your_postgresql_connection_url
HOST_NAME=your_application_base_url
SMTP_CLIENT_USERNAME=your_smtp_username
SMTP_CLIENT_PASSWORD=your_smtp_password

Environment Variable Details

DATABASE_URL
PostgreSQL connection string
(Example: Supabase PostgreSQL URL or local PostgreSQL URL)

HOST_NAME
Base URL of the application
(Used while generating invoice email links)

SMTP_CLIENT_USERNAME / SMTP_CLIENT_PASSWORD
SMTP credentials used to send invoice emails asynchronously

Database Setup

Run the following commands to prepare the database:

rails db:create
rails db:migrate
rails db:seed


db:seed populates default products and initial data required for billing.

Running the Application

Start the Rails server:

rails server


The application will be available at:

http://localhost:3000

Application Features
1. Product Management

Manage products with:

Product Name

Product Code

Available Stock

Price per Unit

Tax Percentage

2. Billing Page

Enter customer email

Dynamically add multiple products to the bill

Enter purchased quantity per product

Accept customer paid amount

Capture available cash denominations

3. Bill Generation

Calculates:

Total price

Tax per product

Final payable amount

Displays bill summary

Calculates balance amount

Determines denominations to return to the customer

4. Invoice Email (Asynchronous)

Invoice email is sent to the customer in the background

Uses Rails background jobs to avoid blocking the UI

5. Purchase History

View previous purchases by customer email

Select a purchase to see purchased product details

Background Jobs & Email

Emails are sent using ActionMailer

Jobs are handled using ActiveJob

In development mode, jobs execute inline by default

Assumptions

Default cash denominations are predefined in the system

Product stock availability is assumed to be sufficient at billing time

SMTP credentials are valid and configured correctly

All assumptions are made in line with the problem statement and standard billing workflows.

Code Quality & Best Practices

MVC architecture strictly followed

Business logic handled in models/services

Clean, readable, and maintainable code

Production-ready structure

Minimal template logic as per task instructions

Conclusion

This project fulfills all the requirements mentioned in the RoR Task Round and is designed to run smoothly on any machine with the prerequisites installed.

For any clarifications or improvements, the codebase is structured for easy extensibility.