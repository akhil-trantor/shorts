# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
##### ruby-2.5.1

* System dependencies

* Configuration
Create application.yml file inside config folder and add following configuration values:
DB_USER_NAME: '********'
DB_PASSWORD: '********'
TEST_DB_NAME: '********'

development:
  DB_NAME: '********'


* Database creation
Run the following command in your terminal:
`rake db:create`

* Database initialization
Run the following command in your terminal:
`rake db:migrate`

* How to run the test suite
Run the following command in your terminal:
`rspec`

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
