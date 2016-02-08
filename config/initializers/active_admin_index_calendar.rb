module ActiveAdmin
  module Views
    class IndexAsCalendar < ActiveAdmin::Component

      def build(page_presenter, collection)
        add_class "calendar"
        data = instance_exec({:page_presenter => page_presenter, :collection => collection}, &page_presenter.block)
      end

      def self.index_name
        "calendar"
      end
    end
  end
end
