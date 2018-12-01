require('pg')
require_relative('./films.rb')
require_relative('./tickets.rb')
# require_relative('../db/cinema.sql')
require_relative('../db/sql_runner.rb')


class Films

attr_reader :id
attr_accessor :title, :price

def initialize(options)
  @id = options['id'].toi if options['id']
  @title = options['title']
  @price = options['price'].to_i
end

def save()
  sql = "INSERT INTO films (
  title,
  price
  ) VALUES (
    $1, $2
    ) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
end

def customer()
  sql = "SELECT customers.* FROM customers
  INNER JOIN films
  ON tickets.customer_id = customers.id
  WHERE films.film_id = films.id "
  values = [@id]
  customer_data = SqlRunner.run(sql, values)
  return Customers.map_items(customer_data)
end

def self.all()
  sql = "SELECT * FROM tickets"
  film_data = SqlRunner.run(sql)
  return Films.map_items(film_data)
end

def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

def self.map(film_data)
  result = film_data.map { |film| Films.new(films)}
  return result
end


end
