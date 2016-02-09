module ActiveAdminIndexAsCalendar
  module DSL

    #
    # Initializes activeadmin index as calendar
    #
    def index_as_calendar( options={}, &block )
      default_options = {
        :ajax => nil,
        :model => nil,   # Needed only for AJAX
        :includes => nil, # Eager loading of related models
        :start_field => :created_at, # Default
        :end_field => nil,
        :block => block
      }
      options = default_options.deep_merge(options)

      # Defines controller for event_mapping model items to events
      controller do
        def event_mapping( items, options )
          events = items.map do |item|
            if !options[:block].blank?
              instance_exec(item, &options[:block])
            else
              {
                :id => item.id,
                :title => item.to_s,
                :start => (options[:start_field].blank? or item.send(options[:start_field]).blank?) ? Date.today.to_s : item.send(options[:start_field])
              }
            end
          end
        end
      end

      # Setup AJAX
      if options[:ajax]

        # Setup fullCalendar to use AJAX calls to retrieve event data
        index as: :calendar do |context|
          events = {
            url: "#{collection_path()}/index_as_events.json",
            type: 'GET',
            data: params
          }
        end

        # Defines collection_action to get events data
        collection_action :index_as_events, :method => :get do
          items = options[:model] || end_of_association_chain
          items = items.send(params[:scope]) if params[:scope].present?
          items = items.includes(options[:includes]) unless options[:includes].blank?
          items = items.where(options[:start_field] => params[:start].to_date...params[:end].to_date).search(params[:q]).result

          events = event_mapping(items, options)

          respond_to do |format|
            format.json { render :json => events }
          end
        end

      # Return events to be used during partial render
      else
        index as: :calendar do |context|
          events = self.controller.event_mapping(context[:collection], options)
        end
      end
    end

  end
end
