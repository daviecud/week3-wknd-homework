require('pg')
require_relative('./films.rb')
require_relative('./tickets.rb')
# require_relative('../db/cinema.sql')
require_relative('../db/sql_runner.rb')

class Customers

  attr_reader :id
  attr_accessor :name, :funds

def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @funds = options['funds'].to_i
end

def save()
  sql = "INSERT INTO customers(
  name,
  funds
  ) VALUES (
    $1, $2
    ) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    # customer_hash = customer[0]
    # id_string = customer_hash['id']
    @id = customer['id'].to_i
end

def films()
  sql = "SELECT films.* FROM Films
  INNER JOINS tickets ON
  tickets.film_id = films.id
  WHERE tickets.customer_id = $1"
  values = [@id]
  film_data = SqlRunner.run(sql, values)
  return Films.map_items(film_data)
end

def update()
  sql = "UPDATE customers SET
  (
    name
    ) = (
      $1
      )
      WHERE id = $2"
      values = [@name, @id]
      SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM customers
  WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE FROM customers"
  customers = SqlRunner.run(sql)
  return customers.map { |person| Customers.new}
end

# def self.all()
#   sql = "SELECT * FROM customers;"
#   customers = SqlRunner.run(sql)
# return customers.map { |person| Customers.new}
# end

def self.all()
  sql = "SELECT * FROM customers"
  customer_data = SqlRunner.run(sql)
  return Customers.map_items(customer_data)
end

def self.map_items(customer_data)
  result = customer_data.map { |customer| Customer.new(customer)}
  return result
end

end
