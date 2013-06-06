# [Earthquake](https://github.com/jugyo/earthquake) plugins

## Pushover updates

This plugin sends Pushover notices when someone favorites one of your tweets or follows you. 

It adds a new command: `:pushover` which sends a test message to Pushover (useful for testing your Pushover configuration).

### Configuration

Create a new app in your Pushover admin board, and puts its token in Earthquake config file:

```ruby
Earthquake.config[:pushover] = {:token => 'XXXXXXXXXXXXX', :user => 'YYYYYYYYYYYYY'}
```

### Known bugs

* a Pushover notice is sent even if YOU favorite a tweet or follows someone
