require('pg')
require_relative('../db/sqlrunner.rb')

class Tag

  attr_accessor(:name)
  attr_reader(:id)

  def initialize(details)
    @id = details['id'].to_i()
    @name = details['name']
  end

  def save()
    sql = '
      INSERT INTO tags
      (name)
      VALUES ($1)
      RETURNING *;'
    values = [@name]
    tag_data = SqlRunner.run(sql, values)
    @id = tag_data.first['id'].to_i()
  end

  def update()
    sql = '
    UPDATE tags SET (name) = $1
    WHERE id = $2'
    values = [@name, @id]
    Sqlrunner.run(sql, values)
  end

  def self.all()
    sql = '
      SELECT * FROM tags'
    values = []
    tags = SqlRunner.run(sql, values)
    result = Tag.map_items(tags)
    return result
  end

  def transaction_total()
    sql = '
    SELECT SUM(value)
    FROM transactions
    WHERE tag_id = $1'
    values = [@id]
    result = SqlRunner.run(sql, values).first['sum'].to_f
    return result
  end

  def self.map_items(rows)
    return rows.map {|row| Tag.new(row)}
  end




end
