require('pry');
require_relative('./models/customers.rb')
require_relative('./models/tickets.rb')
require_relative('./models/films.rb')
# require_relative('../db/sql_runner.rb')

Customers.delete_all()
Films.delete_all()
Tickets.delete_all()

customer1 = Customers.new({'name' => 'Davey', 'funds' => 70})
customer2 = Customers.new({'name' => 'Ally', 'funds' => 100})
customer1.save()
customer2.save()

film1 = Films.new({'title' => 'The Day of the Jackal', 'price' => 8})
film2 = Films.new({'title' => 'The Big Lewboski', 'price' => 10})
film3 = Films.new({'title' => 'Saving Private Ryan', 'price' => 6})
film1.save()
film2.save()
film3.save()

tickets = Tickets.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id
  })
tickets.save()

binding.pry
nil
