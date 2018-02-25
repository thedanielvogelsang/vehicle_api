# README

This project, built over the course of 2 days, is a RESTful json-returning public API for a fictional auto dealership, which has Create, Read, Update and Destroy capability for 4 associated resources:

* VEHICLES
* MAKES
* MODELS
* OPTIONS

Data is populated by first downloading a schema and dataset from a fellow github user kind enough to supply it, as well as several different datasets from the Faker gem -- then this vehicle_api functions as the webserver spitting out json responses to restful requests.

Makes are linked to models, and vehicles inherit from model and make; Vehicles also can be 'purchased' with options, or options added on later. Visit the API endpoints (bottom of README) after setting up the project (below) for further explication.

* Ruby version 2.4.1p111

* System dependencies
  complete instructions here[https://gorails.com/setup/osx/10.13-high-sierra]

    mysql (installation instructions here[https://dev.mysql.com/doc/refman/5.5/en/osx-installation-pkg.html])

    ruby (installation instructions here[https://www.ruby-lang.org/en/documentation/installation/])

    rails (installation instructions here[http://blog.teamtreehouse.com/install-rails-5-mac])

## Deployment instructions
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
  using the above credentials for mysql access, open up a connection to mysql and source their data (once logged in, you can run 'SHOW DATABASES;' to confirm vehicle_api_development has been successfully created):

  cd into their repo after cloning, then run:
  ```shell
    mysql -u dvog_temp -p
    $> Blink3r!
    use vehicle_api_development
    source schema.sql;
    source data.sql;
  ```

#### then, in our vehicle_api repo, import your data using `rake import` and you're ready to go!


===== ====== ====== ====== ====== ====== ====== ====== ===== ===== ===== =====

  **to see the api online, run**
  ```shell
    rails s
  ```
  and visit "http://localhost:3000/api/v1\<resource\>" to see each json response,
  **use Postman to test the create, update, and delete functionality.**

====== ======    ******   ====== =======    ******    ====== ======


  **for testing, run**
  ```shell
    rake db:migrate RAILS_ENV=test
    rspec
  ```

===== ====== ====== ====== ====== ====== ====== ====== ===== ===== ===== =====

## Endpoints

api resource list (all RESTful routes for each resource are available for CRUD):

### Makes
  * GET /api/v1/makes
  * GET /api/v1/makes/:id
  * POST /api/v1/makes?<options>
  * PUT/PATCH /api/v1/makes/:id?<options>
  * DELETE /api/v1/makes/:id

  ```shell
  makes options:
    company: string, must be unique
    company_desc: string, must be unique
    company_motto: string,
    ceo_statement: string

  example:
    GET https://localhost:3000/api/v1/makes

  ```

### Models
  * GET /api/v1/models
  * GET /api/v1/models/:id
  * POST /api/v1/models?\<options\>
  * PUT/PATCH /api/v1/models/:id?\<options\>
  * DELETE /api/v1/models/:id

  ```shell
  models options:
    company: string, must be unique
    make_id: integer, existing make,
    year_id: integer, existing year

    example:
      patch https://localhost:3000/api/v1/models/303?company=New+Company+Name

  ```

### Vehicles
  * GET /api/v1/vehicles
  * GET /api/v1/vehicles/:id
  * POST /api/v1/vehicles?\<options\>
  * PUT/PATCH /api/v1/vehicle/:id?\<options\>
  * DELETE /api/v1/vehicles/:id

  ```shell
  vehicle options:
    vin: string, must be unique
    make_id: integer, existing make,
    model_id: integer, existing year
    options_nums: array, integers, existing options

  example:
    post https://localhost:3000/api/v1/vehicles/3?vin=NewVin&options_nums=1,2,3
  ```

### Options
  * GET /api/v1/options
  * GET /api/v1/options/:id
  * POST /api/v1/options?\<options\>
  * PUT/PATCH /api/v1/options/:id?\<options\>
  * DELETE /api/v1/options/:id

  ```shell
  options options:
    name: string, must be unique,
    description: string, must be unique,
    price: integer,
    promotion_code: integer,
    model_id: integer, existing model

  example:
    DELETE https://localhost:3000/api/v1/options/44
  ```
