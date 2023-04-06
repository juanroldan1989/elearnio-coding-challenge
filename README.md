# Elearnio Coding Challenge

You are responsible for implementing a new API.

The customer requires an app that handles learning paths, courses, course authors and talents.

The API includes CRUD operations for all these items.

The development team already established which language/platform is going to be used the app should use Ruby on Rails 6.0 on the backend and access a Postgres database.

Since it is a prototype, no frontend is required.

Requirements:

1. No authentication methods for this prototype ✅
2. A talent can be assigned to 0 to n courses ✅
3. A talent can be assigned to 0 to n learning paths ✅
4. An author can have 0 to n courses ✅
5. A talent in one course can be the author of another course ✅
6. When deleting an author, the course has to be transferred to another author ✅
7. A learning path can have 1 to n courses, which are ordered in sequence ✅
8. A course can have 0 to n talents and must have 1 author ✅
9. When a talent completes a course in a learning path, they get assigned the next course in the learning path. ✅

Definition of done for this challenge:

- Client can CRUD the data on the API ✅
- Client can mark a course completed for a talent ✅
- No errors ✅
- Rspec for testing ✅
- Documentation where applicable ✅

# API Documentation

<img src="https://github.com/juanroldan1989/elearnio-coding-challenge/raw/main/screenshots/swagger-api-docs.png" width="100%" />

1. Swagger / OpenAPI `YAML` documentation file (format easier to read & maintain) created following standard guidelines: https://github.com/juanroldan1989/elearnio-coding-challenge/blob/main/docs/api/v1/main.yml

2. `YAML` file converted into `JSON` (since `Swagger UI` script requires a `JSON` file):

```ruby
docs/api/v1% brew install yq
docs/api/v1% yq -o=json eval main.yml > main.json
```

3. `JSON` file can be accessed through `Github repository` itself as: https://raw.githubusercontent.com/juanroldan1989/elearnio-coding-challenge/main/docs/api/v1/main.yml or

4. `static` API Documentation `standalone` HTML page generated within `docs/api/v1` folder in repository: https://github.com/swagger-api/swagger-ui/blob/master/docs/usage/installation.md#plain-old-htmlcssjs-standalone

5. Within `static` API Documentation page, replace `url` value with your own `JSON` file's URL from point `3` above:

```ruby
...
    <script>
      window.onload = () => {
        window.ui = SwaggerUIBundle({
          url: "https://raw.githubusercontent.com/juanroldan1989/elearnio-coding-challenge/main/docs/api/v1/main.json?token=XYZ",
          dom_id: '#swagger-ui',
...
```

6. A `static website` can also be hosted within `S3 Bucket`: https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html

- To upload files `aws sync` command is recommended. E.g.: `aws s3 sync docs/api/v1 s3://$YOUR_BUCKET_NAME`

# Development

1. Clone repository:

```ruby
$ git clone git@github.com:juanroldan1989/elearnio-coding-challenge.git
```

2. Setup environment, install dependencies and launch server:

```ruby
$ brew install postgresql@14
$ brew services start postgresql@14

$ cd elearnio-coding-challenge
$ bundle install
$ bundle exec rake db:migrate
$ rails s
```

```ruby
Ruby Version: `2.5.7`
Rails Version: `6.0.0`
```

## Using docker containers

1. Add `Dockerfile` first:

```ruby
FROM ruby:2.5.7

LABEL maintainer="Juan Roldán <juanroldan1989@gmail.com>"

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

ADD . /myapp
WORKDIR /myapp

RUN bundle install

# Add a script to be executed every time the container starts.
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3000

# Configure the main process to run when running the image
CMD [ "puma", "-C", "config/puma.rb" ]
```

2. Build Rails App image and run API & Database containers:

```ruby
# build the Rails App image from Dockerfile
$ docker build -t juanroldan1989/elearnio-coding-challenge .

# in case is required when pushing image
# docker login

# Docker image uploaded into https://hub.docker.com/u/juanroldan1989
$ docker push juanroldan1989/elearnio-coding-challenge

# create the network
$ docker network create elearnio-net

# start Postgres container
$ docker run -d --name db --net elearnio-net -e POSTGRES_USER=juan -e POSTGRES_PASSWORD=123456 -p 5432:5432 postgres:9.6-alpine

# start Rails App container
$ docker run -d --name web --net elearnio-net -p 3000:3000 juanroldan1989/elearnio-coding-challenge

# checking logs inside Rails app
# docker exec -it web bash
#   root@6ed1fe1ac6fe:/myapp#
#     tail -f log/development.log

# database tasks
$ docker exec web rake db:create db:migrate db:test:prepare
```

3. Access `localhost:3000` within browser

4. Troubleshooting Rails `database.yml` file configuration:

- Running App with Docker containers:

* `database` needs to be commented out
* `host` needs to be `db` (or DB container's name)
* `username` needs to match the one used for creating DB container
* `password` needs to match the one used for creating DB container

- Running App without Docker containers:

* `database` needs to be present
* `host` needs to be commented out
* `username` needs to match the one used in local postgres setup
* `password` needs to match the one used in local postgres setup

# Local API Testing

```ruby
$ rspec spec/*
........................................

Finished in 1.85 seconds (files took 2.05 seconds to load)
40 examples, 0 failures

# `*` is important since it runs both `controller` AND `model` RSpec tests
```

# Live (or staging) API Testing

For these purposes, `Artillery` is a really useful framework used for load testing and gathering results on different endpoints.

https://www.artillery.io/docs/guides/getting-started/installing-artillery

https://www.artillery.io/docs/guides/integration-guides/github-actions

Artilley Config/Scenarios references: https://www.artillery.io/docs/guides/guides/test-script-reference

https://dev.to/brpaz/load-testing-your-applications-with-artillery-4m1p

AWS references: https://aws.amazon.com/blogs/compute/load-testing-a-web-applications-serverless-backend/

# CI/CD

Sample Github Actions structure provided at `.github/workflows/ci_cd.yml` along with `rspec`, `deployment` and `notification` jobs to have a proper CI/CD Pipeline to be shared among colleagues while working through the API.

# Deployment

Heroku instructions: https://devcenter.heroku.com/articles/getting-started-with-rails6

AWS Deployment can be achieved through Terraform:

https://developer.hashicorp.com/terraform/tutorials/automation/github-actions
