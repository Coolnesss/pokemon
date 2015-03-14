module RawSqlUtil
  
def sql_select(sql, params)

  # We have to do this weirdness because sanitize_sql_array is a protected method
  query = ActiveRecord::Base.send(:sanitize_sql_array, [sql].concat(params))

  ActiveRecord::Base.connection.select_all(query)
end

def sql_select_values(sql, params, result_cols)
  # Returns an array of single values if only one result_col is given, otherwise it returns an array of arrays whose
  # values correspond to the given result_cols order.

  result = sql_select(sql, params)

  if not result_cols.is_a?(Array)
    # return single values
    result.map { |row| row[result_cols] } || []
  else
    result.map do |row|
      # return array of values
      result_cols.each { |col| row[col] }
      end
    end
  end

end
