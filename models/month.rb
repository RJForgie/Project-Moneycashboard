# require('pry')

class Month

  MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

  attr_accessor(:month, :total, :month_name)

  def initialize(details)
    @month = details['month'].to_i
    @total = details['total'].to_f
    @month_name = MONTHS[@month - 1]
  end


  def self.total_by_month()
    sql = '
      SELECT SUM(value) AS total, EXTRACT(MONTH from transaction_date) AS month
      FROM transactions
      GROUP BY EXTRACT(MONTH from transaction_date)'
    values = []
    months = SqlRunner.run(sql,values)
    keyed = key_by_month(Month.map_items(months))

    result = (1..12).map { |month_number| keyed[month_number] || Month.new({
        "month" => month_number,
        "total" => "0"
      })
    }
    return result
  end

  def self.key_by_month(months)
    result = []
    months.each do |month|
      result[month.month] = month
    end
    return result
  end

  def self.map_items(rows)
    return rows.map {|row| Month.new(row)}
  end

end
