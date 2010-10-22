development:
  adapter: sqlite3
  database: db/development.sqlite3
  timeout: 5000

test:
  adapter: sqlite3
  database: ':memory:' 
  verbosity: silent
  timeout: 5000

production:
  adapter: postgresql
  database: cwnmyr
  username: cwnmyr
  password:

