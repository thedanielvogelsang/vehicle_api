``# README

* This project, built over the course of 2 days, is a RESTful json-returning public API for a fictional auto dealership, which has Create, Read, Update and Destroy capability for 4 associated resources:

* VEHICLES
* MAKES
* MODELS
* OPTIONS

Data is populated by first downloading a schema and dataset from a fellow github user kind enough to supply it, as well as several different datasets from the Faker gem -- then this vehicle_api functions as the webserver spitting out json responses to restful requests.

* Ruby version 2.4.1p111

* System dependencies
  complete instructions here[https://gorails.com/setup/osx/10.13-high-sierra]

    mysql (installation instructions here[https://dev.mysql.com/doc/refman/5.5/en/osx-installation-pkg.html])

    ruby (installation instructions here[https://www.ruby-lang.org/en/documentation/installation/])

    rails (installation instructions here[http://blog.teamtreehouse.com/install-rails-5-mac])

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

  ===== ====== ====== ====== ====== ====== ====== ====== ===== ===== ===== =====

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

  ===== ====== ====== ====== ====== ====== ====== ====== ===== ===== ===== =====

  **for testing, run**
  ```shell
    rake db:migrate RAILS_ENV=test
    rspec
  ```


* ...
