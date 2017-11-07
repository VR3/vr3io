![VR3](http://static.vr3.io/vr3/img/logos/vr3_256.png)

# VR3.io

> VR3 

This is the web application source code written in Ruby on Rails and Bootstrap.

Maintained by **[oschvr](https://cdtwitter.com/oschvr)**

## Dependencies

- Ruby 2.4.0
- Rails 5.0
- PostgreSQL 9.6
- Bundler 1.16.0

## Installing

First clone the repository

`$ git clone https://github.com/VR3/vr3io`

Get into the directory 

`$ cd vr3io/`

Install the gems using bundle

`$ bundle install`


### Database Creation

> Make sure to have an active `psql` connection

Create the databases and migrate them

`$ rake db:create db:migtate`

### Starting the Server

> Make sure to have open the port `3000`

`$ rails server`

Open `localhost:3000` in the browser

### Deployment

Precompile the assets and include them in the commit

`$ rake assets:precompile`

Using heroku, follow [this](https://devcenter.heroku.com/articles/getting-started-with-rails5) guide and then push the app

`$ git push heroku master`

### License

MIT