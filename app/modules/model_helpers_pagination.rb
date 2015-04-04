module ModelHelpers
  module Pagination
    def self.included(base)
      base.extend(ClassMethods)
    end

    public

    module ClassMethods
      def default_paginate_per_page
        @@default_paginate_per_page ||= 25
      end

      def default_paginate_per_page=(value)
        @@default_paginate_per_page = value
      end
    end # ClassMethods

    protected

    attr_accessor :paginate_page
    attr_accessor :paginate_per_page

    def paginate_params
      {page: @paginate_page.presence || 1, per_page: @paginate_per_page.presence || self.class.default_paginate_per_page}
    end

  end
end