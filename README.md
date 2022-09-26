# Weather Api

### Configuration

* Ruby: 3.0.1
* Rails: 7.0.1
* Redis: 4.0
* Sidekiq: 6.5.6
* Postgres: 14.4.0
* Rspec-rails: 5.1.2
* Rspec-sidekiq: 3.1.0
* Webmock: 3.18.1
* Factory_bot_rails: 6.2.0
* Vcr: 6.1.0

### Setup

* Create and migrate database.

```ssh
 rails db:create db:migrate
```

* run server

```ssh
forman start
```

### Endpoints

* List all weathers `GET /weathers`.
* Search current weather location `POST /weather/current`, params `{token: '', location: ''}`.
* Get current weather result `GET /weather/current/result`, params `{token: ''}`.
* Remove weather `DELETE /weather/:id`.

