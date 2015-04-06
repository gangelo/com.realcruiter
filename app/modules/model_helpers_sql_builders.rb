module ModelHelpers
  module SqlBuilders
    def self.included(base)
      base.extend(ClassMethods)
    end

    private

    module ClassMethods
      def build_sql_where_clause(table, column, values)
        table = ensure_string(table)
        column = ensure_string(column)
        values = ensure_array(values)

        the_clause = []

        values.each_with_index.map do |value,index| 
          clause = "LOWER(#{qualify_column(table,column)}) = LOWER('#{value}')"
          clause = "AND #{clause}" unless index == 0
          the_clause << clause
        end

        the_clause.join(' ')
      end

      def build_sql_in_clause(table, column, values)
        table = ensure_string(table)
        column = ensure_string(column)
        values = ensure_array(values)

        the_clause = ["LOWER(#{qualify_column(table,column)})", 'IN', '(']

        values.each_with_index.map do |value,index| 
          clause = "LOWER('#{value}')"
          clause = ", #{clause}" unless index == 0
          the_clause << clause
        end

        the_clause << ')'
        the_clause.join(' ')
      end

      private

      def ensure_string(object)
        object.to_s if object.instance_of? Symbol
        object
      end

      def ensure_array(object)
        object = [object].flatten unless object.instance_of? Array
        object
      end

      def qualify_column(table, column)
        "#{table}.#{column}"
      end

    end
  end
end