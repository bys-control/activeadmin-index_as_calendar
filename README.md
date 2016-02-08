activeadmin index as calendar
=============================

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
ActiveAdmin.register Hours do

  index as: :calendar
  
end
```

This will render a default calendar view with the following options:
```RUBY
events = collection.map do |item|
  {
    id: item.id,
    title: item.to_s,
    start: item.created_at.blank? ? Date.today.to_s : item.created_at,
    url: "#{auto_url_for(item)}"
  }
end
```

### Advanced configuration

Rendered events can be configured as specified in [fullCalendar documentation](http://fullcalendar.io/docs/event_data/Event_Object/). The following example show a use case.

```RUBY
ActiveAdmin.register Hours do

  index as: :calendar do |context|
    hours = context[:collection].includes([:admin_user, :project, :partner])
  
    # Builds events array to be rendered by fullCalendar
    events = hours.map do |item|
      {
        id: item.id,
        title: item.title,
        start: item.created_at,
        url: "#{admin_hour_path(item.id)}",
        tooltip: {
          title: item.title,
          text: item.description
        }
      }
    end
  end
end
```
