## Payment System Task

- Configured and added Rubocop

- Added Rspec

- Added devise for authentication

- Added validations and associations

- Added slim templates

- Added interactor for encapsulating the business logic

- Added basic design for merchant and admin

- Added rake task for importing merchants and admins

- Fasted bulk import using PG Copy

- Added JWT for API authentication

- Added Whenever for cron job

- Added Sidekiq for background processing

## Tech stack:
* Rails 6.1.1
* Ruby 3.0.0
* PostgreSQL

## Setup
```
rails db:create db:migrate db:seed
rails s
```
To execute rake task for bulk merchant import run:
`bundle exec rake merchants:bulk_import_merchants\['lib/tasks/import_merchants.csv'\]`

## APIs
* Postman Document: https://documenter.getpostman.com/view/12376574/TW77gim3