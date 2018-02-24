# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies
  mysql (installation instructions here[])
  ruby (installation instructions here[])
  rails (installation instructions here[])

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
  clone repo and cd into it
  run
  ```shell
    gem install bundle
    bundle install
    rake db:drop
    rake db:create
    rake db:migrate
  ```

  visit https://github.com/n8barr/automotive-model-year-data and follow the instructions using the below username and password ***instead of root***

  clone their repo in a different place on your computer; cd into it (i like to open two different bash windows, one for mysql, and the other for my Rails app);

  ```shell
    username: dvog_temp
    password: Blink3r!
  ```
  using the above credentials for mysql access, open up a connection to mysql and source their data:

  cd into their repo after cloning, then run:
  ```shell
    mysql -u dvog_temp -p
    $> Blink3r!
    use vehicle_api_development
    source schema.sql;
    source data.sql;
  ```
  then, in our vehicle_api repo, import your data using `rake import` and you're ready to go!

  ===== ====== ====== ====== ====== ====== ====== ====== ===== =====

  **to see the api online, run**
  ```shell
    rails s
  ```
  and visit "http://localhost:3000/api/v1/\<resource\>" to see each json response,
  **use Postman to test the create, update, and delete functionality.**

  api resource list (all RESTful routes for each resource are available for CRUD):
    * makes
    * models
    * vehicles
    * options

  **for testing, run**
  ```shell
    rake db:migrate RAILS_ENV=test
    rspec
  ```


* ...
