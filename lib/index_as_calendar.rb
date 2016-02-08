require "index_as_calendar/version"
require "index_as_calendar/engine"
require "index_as_calendar/dsl"

# ensure that ActiveAdmin is loaded
require "active_admin"

module ActiveAdminIndexAsCalendar
end

# Permite que los helpers estén accesibles desde los Resources de Active Admin
ActiveAdmin::ResourceDSL.send :include, ActiveAdminIndexAsCalendar::DSL