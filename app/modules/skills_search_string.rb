module Skills
  module SearchString
    def self.included(base)
    end

    private

    def tokenize_search_string(search_string)
      tokens = search_string || []
      tokens = tokens.squeeze(' ').split(',').uniq.map(&:strip).reject(&:empty?) unless tokens.empty?
    end

    def prettify_search_string(search_string)
      tokenize_search_string(search_string).join(', ')
    end
  end
end