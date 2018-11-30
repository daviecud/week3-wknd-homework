require('pg')

class Tickets

  attr_reader :customer_id, :film_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @cutomer_id = options['customer_id'].to_i
  @film_id = options['film_id'].to_i
end





end
