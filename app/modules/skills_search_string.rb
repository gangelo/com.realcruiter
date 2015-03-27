module Skills
  module SearchString
    def self.included(base)
    end

    private

    def tokenize_search_string(search_string)
      tokenize(search_string)
    end

    def prettify_search_string(search_string)
      tokenize(search_string).join(', ')
    end

   def tokenize(search_string)
    search_string = clean(search_string)
    search_string.empty? ? [] : search_string.squeeze(' ').split(',').uniq.map(&:strip).reject(&:empty?)
    end

    def clean(search_string)
      search_string ||= ''
      search_string.strip! unless search_string.empty?
      search_string
    end
  end
end