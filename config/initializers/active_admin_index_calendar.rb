module ActiveAdmin
  module Views
    class IndexAsCalendar < ActiveAdmin::Component

      def build(page_presenter, collection)
        add_class "calendar"
        context = {:page_presenter => page_presenter, :collection => collection, :fullCalendarOptions => nil}
        events = instance_exec(context, &page_presenter.block) unless page_presenter.block.blank?

        # Render fullCalendar
        panel "Calendar", id: "calendar" do
          render :partial => "calendar", locals: {events: events, options: context[:fullCalendarOptions].to_json.html_safe}
        end
      end

      def self.index_name
        "calendar"
      end
    end
  end
end
