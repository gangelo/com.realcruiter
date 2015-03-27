module ModelHelpers
  module TransformToAttributes
    def self.included(base)
    end

    private

    def transform_to_attributes(klasses, key=nil)
      return { key || :nil => {} } unless klasses.respond_to?(:each_with_index) && klasses.all? { |klass| klass.respond_to?(:attributes) }
      array = []
      klasses.each_with_index do |item, index| 
        array << { "#{index}" => item.attributes }
      end unless klasses.empty?
      wrap_hash(array.reduce({}, :merge), key)
    end

    def wrap_hash(hash, key)
      key ? { key => hash } : hash
    end
  end
end