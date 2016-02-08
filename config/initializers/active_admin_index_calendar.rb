module ActiveAdmin
  module Views
    class IndexAsCalendar < ActiveAdmin::Component

      def build(page_presenter, collection)
        add_class "calendar"
        context = {:page_presenter => page_presenter, :collection => collection}
        events = instance_exec(context, &page_presenter.block)

        # Builds default events array for collection if page_presenter.block returns no data
        if events.blank?
          events = collection.map do |item|
            {
              id: item.id,
              title: item.to_s,
              start: item.date_hour,
              url: "#{auto_url_for(item)}"
            }
          end
        end

        # Render fullCalendar
        panel "Calendar", id: "calendar" do
          render :partial => "calendar", locals: {events: events, options: context[:fullCalendar_options].to_json.html_safe}
        end
      end

      def self.index_name
        "calendar"
      end
    end
  end
end
