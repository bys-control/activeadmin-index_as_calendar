$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "index_as_calendar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin-index_as_calendar"
  s.version     = IndexAsCalendar::VERSION
  s.authors     = ["ByS Sistemas de Control"]
  s.email       = ["info@bys-control.com.ar"]
  s.homepage    = "https://github.com/bys-control/activeadmin-index_as_calendar"
  s.summary     = "Adds support to show resources indexes as calendar in ActiveAdmin"
  s.description = "Adds support to show resources indexes as calendar in ActiveAdmin using fullCalendar JQuery plugin"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4"
  #s.add_dependency "activeadmin", "~> 0"

  s.add_dependency 'momentjs-rails', '~> 2.11'
  s.add_dependency 'fullcalendar-rails', '~> 2.6'

  s.add_development_dependency "sqlite3", "~> 0"
end
