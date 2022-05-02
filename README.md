# Installation

```
bundle install
```

```
rake db:setup
rake db:create
rake db:migrate
```

# Start server

```
rails s
```

# Possible request examples

### Get stocks list
```
curl -X GET  http://127.0.0.1:3000/api/v1/stocks -H "Content-Type: application/json"
```

### Get stock with current id
```
curl -X GET  http://127.0.0.1:3000/api/v1/stocks/:id -H "Content-Type: application/json"
```

### Create new stock
```
curl -X POST  http://127.0.0.1:3000/api/v1/stocks -H "Content-Type: application/json" -d '{"name": "stock1", "bearer": {"name": "bearer1"}}'
```

### Update current stock
```
curl -X PATCH  http://127.0.0.1:3000/api/v1/stocks/:id -H "Content-Type: application/json" -d '{"name": "stock2"}'
```

### Delete current stock
```
curl -X DELETE  http://127.0.0.1:3000/api/v1/stocks/:id -H "Content-Type: application/json"'
```

# Run test

```
rspec spec/
```
