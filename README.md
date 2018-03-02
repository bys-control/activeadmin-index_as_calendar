# activeadmin index as calendar

[![Gem Version](https://badge.fury.io/rb/activeadmin-index_as_calendar.svg)](https://badge.fury.io/rb/activeadmin-index_as_calendar)

ActiveAdmin plugin that adds calendar index to [ActiveAdmin](https://github.com/activeadmin/activeadmin) resources. It uses [fullCalendar](http://fullcalendar.io/) JQuery plugin to render resource collection to a calendar view.

## Installation:

Add this line to your application's Gemfile:

```RUBY
gem 'activeadmin-index_as_calendar', github: 'bys-control/activeadmin-index_as_calendar'
```

In app/assets/javascripts/active_admin.js add
```JAVASCRIPT
//= require index_as_calendar/application
```

In app/assets/stylesheets/active_admin.css.scss add
```CSS
@import "index_as_calendar/application"
```

Finally, run `bundle install`

## Usage

### Basic usage

To render default calendar for your AA resource do

```RUBY
ActiveAdmin.register Invoices do

  index_as_calendar
  
end
```

This will render a default calendar view with default event options:
```RUBY
events = collection.map do |item|
  {
    id: item.id,
    title: item.to_s,
    start: item.created_at.blank
  }
end
```

### Customization

```RUBY
ActiveAdmin.register Invoices do

  index_as_calendar ({:ajax => true, :includes => [:partner]}) do |item|
    {
      id: item.id,
      title: item.partner.name,
      start: item.issue_date,
      url: "#{admin_invoice_path(item)}",
      tooltip: {
       title: "Due date #{item.due_date.to_s}",
       text: item.balance.blank? ? nil : item.balance.to_s
      },
      color: item.balance>0 ? (item.due_date.blank? ? 'green' : (item.due_date <= DateTime.now.beginning_of_day ? 'red' : 'olive' )) : 'green',
      textColor: 'white'
    }
  end
end
```

The helper function `index_as_calendar` receives a hash with configuration parameters and a code block that should return a hash with the mappings of model fields to event fields. Rendered events can be configured as specified in [fullCalendar documentation](http://fullcalendar.io/docs/event_data/Event_Object/).

Configuration parameters defaults to:

```RUBY
default_options = {
  :ajax => true,   # Use AJAX to fetch events. Set to false to send data during render.
  :model => nil,   # Model to be used to fetch events. Defaults to ActiveAdmin resource model.
  :includes => [], # Eager loading of related models
  :order => [],    # Order the objects
  :start_date => :created_at, # Field to be used as start date for events
  :end_date => nil, # Field to be used as end date for events
  :block => block # Block with the model<->event field mappings
}
```
