require('pg')
class SqlRunner

  def self.run(sql, values)
    begin
      db = PG.connect({ dbname: 'd1h3e89kv99r98', host: 'ec2-54-225-237-64.compute-1.amazonaws.com',
        port: 5432, user: 'yfwhoihlaasmdf', password: '846dd83f243cc1f79a6382449a078ea25ceaab36f1ccc5f1545acf7a79791f3a'})
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close
    end
    return result
  end

  end
