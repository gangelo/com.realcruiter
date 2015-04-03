module ModelHelpers
  module SqlBuilders
    def self.included(base)
      base.extend(ClassMethods)
    end

    private

    module ClassMethods
      def build_sql_where_clause(table, column, values)
        table = table.to_s if table.instance_of? Symbol
        column = column.to_s if column.instance_of? Symbol
        values = [values].flatten unless values.instance_of? Array

        where_clause = []

        values.each_with_index.map do |value,index| 
          clause = "lower(#{table}.#{column}) = lower('#{value}')"
          clause = "AND #{clause}" unless index == 0
          where_clause << clause
        end

        where_clause.join(' ')
      end
    end
  end
end