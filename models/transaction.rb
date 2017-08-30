require('pg')
require_relative('../db/sqlrunner.rb')

class Transaction

  attr_accessor(:value, :merchant_id, :transaction_date, :tag_id)
  attr_reader(:id)

  def initialize(details)
    @id = details['id'].to_i()
    @value = details['value']
    @merchant_id = details['merchant_id'].to_i
    @transaction_date = details['transaction_date']
    @tag_id = details['tag_id'].to_i
  end

  def save()
    sql = '
      INSERT INTO transactions
      (value, merchant_id, transaction_date, tag_id)
      VALUES ($1, $2, $3, $4)
      RETURNING *;'
    values = [@value, @merchant_id, @transaction_date, @tag_id]
    transaction_data = SqlRunner.run(sql, values)
    @id = transaction_data.first['id'].to_i()
  end

  def update()
    sql = '
      UPDATE transactions SET (value, merchant_id, transaction_date, tag_id)
      = ($1, $2, $3, $4)
      WHERE id = $5;'
      values = [@value, @merchant_id, @transaction_date, @tag_id, @id]
      SqlRunner.run(sql, values)
  end

  def self.all()
    sql = '
      SELECT * FROM transactions'
    values = []
    transactions = SqlRunner.run(sql, values)
    result = Transaction.map_items(transactions)
    return result
  end

  def self.find(id)
    sql = '
      SELECT * FROM transactions WHERE id = $1'
    values = [id]
    transaction = SqlRunner.run(sql, values)
    result = Transaction.new(transaction.first)
    return result
  end

  def self.map_items(rows)
    return rows.map {|row| Transaction.new(row)}
  end

  def self.delete_all()
    sql = '
      DELETE FROM transactions'
    values = []
    SqlRunner.run(sql, values)
  end

  def self.delete(id)
    sql = '
      DELETE FROM transactions
      WHERE id = $1;'
    values = [id]
    SqlRunner.run(sql, values)
  end

  def which_merchant()
    sql = '
      SELECT * FROM merchants
      WHERE id = $1'
    values = [@merchant_id]
    merchant = SqlRunner.run(sql, values)
    result = Merchant.new(merchant.first)
    return result
  end

  def which_tag()
    sql = '
      SELECT * FROM tags
      WHERE id = $1'
    values = [@tag_id]
    tag = SqlRunner.run(sql, values)
    result = Tag.new(tag.first)
    return result
  end

  def self.total()
    sql = '
      SELECT SUM(value)
      FROM transactions'
    values = []
    result = SqlRunner.run(sql, values).first['sum'].to_f
    return result
  end

end
