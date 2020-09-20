# League Finder BETA 🌎💰⚾ 🔍️✨
a coding challenge for my good friends at LeagueSide

# What does it do?

This app provides two simple endpoints for leagues to upload themselves, and for sponsors to see a individual leagues as well as a list of leagues that are within an area they care about and within their budget.


# Running locally

This guide assumes that the reader has Ruby version 2.5.3 or greater installed along with SQLite3.  Further info for those unfamiliar with theee framework can be found at https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project. 

The steps to get a dev server running should be familiar.  After cloning down this code repository, cd in to the `league-finder` directory and run the following:
* `bundle install` to install dependencies
* `bundle exec rake db:create` to initialize the sqlite database locally
* `bundle exec rake db:migrate` to run migrations and set out database schema
* `bundle exec rake db:seed` to load up the database with a few sample records
* `budle exec rails server` to start the server

From there, you can send `GET` and `POST` requests to http://localhost:3000/leagues with your favorite client to your heart's content!

# Api Spec 

 `POST` requests to the `/leagues` endpoint with a `name`, `price`, `latitude`, and `longitude` will create the league if valid, and return an error message if not.  All parameters are required.
 
 `GET` requests to the `/leagues` endpoint will return all leagues
 
 `GET` requests to the `/leagues` endpoint with `latitude`, `longitude`, and `range` parameters (range provided in miles) will return all leagues within the given range.
 
 `GET` requests to the `/leagues` endpoint with a `budget` parameter will return a list of leagues sorted by budget, lowest first, with the maximum number of leagues that could conceivably fit within the given budget based on Price, which is assumed to be provided in cents.
 
 `Get` requests to `/leagues/:id` will return a simple view of the one league.
 
# Sample requests:
 
 Running `curl -X GET http://localhost:3000/leagues` in the command line will get all leagues
 
  Running `curl -X GET -d 'latitude=40.689247&longitude=-74.044502&range=2&budget=10000' http://localhost:3000/leagues` will get you the maximum number of leagues within two miles of the statue of liberty who will fit within a 100 dollar (i.e. 10_000 cent) budget.
  
  Running `curl -X POST -d "name=The Bat Boys&price=1000&latitude=41.9484&longitude=87.6553" http://localhost:3000/leagues` will create a league that looks something like this:
  
  ```
  {
    "id":9,
    "name":"The Bat Boys",
    "price":1000,
    "latitude":"41.9484",
    "longitude":"87.6553",
    "created_at":"2020-09-19T23:29:49.500Z",
    "updated_at":"2020-09-19T23:29:49.500Z"
}
```

# What were some trade-offs?

Rails is easy to expand, but this could have easily been a much lighter weight Sinatra app. That said, it would probably be easier to extend this in to an enterprise app, and it is nice to just roll with convention and know that most Rails coders would be able to figure out what's going on right away.

This project ships with no tests, because I only had a couple hours to work on it for this code challenge.  Production code shouldn't ship without at least a simple request spec with a few sample objects. Similarly, a Rubocop-based linter, a bare-bones front end client, and some circle configs to run tests on pull request creation would be high on my list of things to do in the first day of bootstrapping a real service.

We could have manually calculated distance from latitude and longitude instead of bringing in a library.  Advantages to not relying on external gems include possible being more performant for this relatively simple case, more explicit, or more secure, as well as reducing bundle size, but geocoding has quite a few edge cases and I'd be very unlikely to not use a library in production unless we were running in to terrible issues with the integration.

