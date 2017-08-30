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
    merchant_data = SqlRunner.run(sql, values)
    @id = merchant_data.first['id'].to_i()
  end

  def update()
    sql = '
      UPDATE merchant SET (name) = $1
      WHERE id = $2'
    values = [@name, @id]
    Sqlrunner.run(sql, values)
  end

  def self.all()
    sql = '
      SELECT * FROM merchants'
    values = []
    merchants = SqlRunner.run(sql, values)
    result = Merchant.map_items(merchants)
    return result
  end

  def self.find(id)
    sql = '
      SELECT * FROM merchants WHERE id = $1'
    values = [id]
    merchant = SqlRunner.run(sql, values)
    result = Merchant.new(merchant.first)
    return result
  end

  def self.delete(id)
    sql = 'DELETE FROM merchants WHERE id = $1;'
    values = [id]
    SqlRunner.run(sql, values)
  end

  def transaction_total()
    sql = '
    SELECT SUM(value)
    FROM transactions
    WHERE merchant_id = $1'
    values = [@id]
    result = SqlRunner.run(sql, values).first['sum'].to_f
    return result
  end

  def self.map_items(rows)
    return rows.map {|row| Merchant.new(row)}
  end

  def self.names()
    merchants = Merchant.all
    names = merchants.map {|merchants| merchants.name }
    return names
  end

end
