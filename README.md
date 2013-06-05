# capistrano-progress

Adds a new command run\_with\_progress, simillar to run, which will
display a (ascii) graphical progress of each server running the command

## Example

```ruby
require 'capistrano-progress'

set :user, "vagrant"

role :foo, "1.localhost.tv:2222"
role :foo, "2.localhost.tv:2222"
role :foo, "3.localhost.tv:2222"
role :foo, "4.localhost.tv:2222"
role :foo, "5.localhost.tv:2222"
role :foo, "6.localhost.tv:2222"

task :foo, :roles => [:foo] do
  run_with_progress "/opt/vagrant_ruby/bin/ruby -e 'sleep rand(10)'"
end
```

## Contributing to capistrano-progress

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 Piotr Banasik. See LICENSE.txt for
further details.

