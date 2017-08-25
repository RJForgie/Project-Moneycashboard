require('pg')
require_relative('../db/sqlrunner.rb')

class Merchant

  attr_accessor(:name)
  attr_reader(:id)

  def initialize(details)
    @id = details['id'].to_i
    @name = details['name']
  end

  def save()
    sql = '
      INSERT INTO merchants
      (name)
      VALUES ($1)
      RETURNING *;'
    values = [@name]
    tag_data = SqlRunner.run(sql, values)
    @id = tag_data.first['id'].to_i()
  end

end
