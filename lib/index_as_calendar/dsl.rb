module ActiveAdminIndexAsCalendar
  module DSL
    attr_accessor :index_as_calendar_enabled

    #todo: falta completar el pasaje de opciones de configuracion para especificar los partials a renderizar
    def index_as_calendar options={}
      default_options = {
          quick_new_partial: nil,
          quick_create_partial: nil,
          collection: config.resource_class,
      }
      options = default_options.deep_merge(options)

      @index_as_calendar_enabled = true
    end
  end
end