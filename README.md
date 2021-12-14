# Valera Online
![Unit Tests & Lint](https://github.com/Napwob/Project412/workflows/Unit%20Tests%20&%20Lint/badge.svg)  
This files implements Marginal Valera game using "Ruby on Rails"
### Require  
 * Ruby 3.0.3
### PostgreSQL installation
 * sudo apt install postgresql
 * sudo gem install pg
 * sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"
 * sudo -u postgres createdb rails_starter_project_development
### Set up
 * gem install bundler
 * bundle install
 * rails db:migrate
 * rails db:create
### Rspec
 * rspec
### Rubocop
 * rubocop
 * rubocop -A # Auto-correct offenses
### Run
 * rails s
