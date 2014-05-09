module Measurable
  extend ActiveSupport::Concern

  module ClassMethods
    def group_by_month
      self.group("DATE_TRUNC('month', created_at)").count.sort.reverse
    end
  end
end
