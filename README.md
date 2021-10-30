# Installation

In Gemfile, add:
```ruby
gem 'syndesmos', git: 'https://github.com/TheStranjer/syndesmos/', branch: 'akro'
```

Then `bundle install`.

# Usage

```ruby
require 'syndesmos'

client = Syndesmos.new(instance: "domain.tld", bearer_token: "fhwdgads")
client.scrobbles({ artist: "Boa", title: "Duvet" })
client.statuses({ status: "I just made my first scrobble! And you don't even understand..."})
```

# Other Endpoints

| Instance Method | HTTP Method | URI
| --------------- | ----------- | ---
`update_credentials` | `PATCH ` | `/api/v1/accounts/update_credentials`
`emoji             ` | `GET   ` | `/api/pleroma/emoji`
`captcha           ` | `GET   ` | `/api/pleroma/captcha`
`home              ` | `GET   ` | `/api/v1/timelines/home`
`direct            ` | `GET   ` | `/api/v1/timelines/direct`
`public            ` | `GET   ` | `/api/v1/timelines/public`
`notifications     ` | `GET   ` | `/api/v1/notifications`
`peers             ` | `GET   ` | `/api/v1/instance/peers`
`verify_credentials` | `GET   ` | `/api/v1/accounts/verify_credentials`
`following         ` | `GET   ` | `/api/v1/accounts/$ID/following`
`followers         ` | `GET   ` | `/api/v1/accounts/$ID/followers`
`scrobbles         ` | `GET   ` | `/api/v1/pleroma/accounts/$ID/scrobbles`
`get_statuses      ` | `GET   ` | `/api/v1/accounts/$ID/statuses`
`peers             ` | `GET   ` | `/api/v1/instance/peers`
`get_relay         ` | `GET   ` | `/api/v1/pleroma/admin/relay`
`favourite         ` | `POST  ` | `/api/v1/statuses/$ID/favourite`
`unfavourite       ` | `POST  ` | `/api/v1/statuses/$ID/unfavourite`
`reblog            ` | `POST  ` | `/api/v1/statuses/$ID/reblog`
`unreblog          ` | `POST  ` | `/api/v1/statuses/$ID/unreblog`
`follow            ` | `POST  ` | `/api/v1/accounts/$ID/follow`
`unfollow          ` | `POST  ` | `/api/v1/accounts/$ID/unfollow`
`unsubscribe       ` | `POST  ` | `/api/v1/pleroma/accounts/$ID/unsubscribe`
`post_statuses     ` | `POST  ` | `/api/v1/statuses`
`scrobble          ` | `POST  ` | `/api/v1/pleroma/scrobble`
`post_relay        ` | `POST  ` | `/api/v1/pleroma/admin/relay`

