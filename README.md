# Todo-offline (online)

Rails version 5.1.5
Ruby Version 2.5.0

## Dependencies

### Required
- postgresql version 9.4 or newer (compatible with 10)

## Getting Running
###Ruby Dependencies

```
$ bundle install
```

### Application Configuration
1. Add Database Config:
```
$ cp config/database.yml.example config/database.yml
```
2. confirm the settings in this file are compatible with your database
3. load Database
```
$ bundle exec rails db:setup
```

## Start the server

I recommend you use `bundle exec guard` to run the rails server in development. but you can also run `bundle exec rails s` as usual

## Test suite

The tests can be run with `bundle exec rspec spec` or continuously with `bundle exec guard`
