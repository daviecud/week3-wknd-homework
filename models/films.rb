require('pg')

class Films

attr_reader :id, :title
attr_accessor :price

def initialize(options)
  @id = options['id'].toi if options['id']
  @title = options['title']
  @price = options['price']
end



end
