require 'minitest/autorun'
require 'json'

module SyndesmosTest
  class Login < Minitest::Test
    def test_can_login_with_bearer_token
      example = {"acct":"NEETzsche","avatar":"https://iddqd.social/media/3f1b3b8abdc00351d2907df8a826e418ee1939b3b49954804fee848009fa004a.jpg?name=blob.jpg","avatar_static":"https://iddqd.social/media/3f1b3b8abdc00351d2907df8a826e418ee1939b3b49954804fee848009fa004a.jpg?name=blob.jpg","bot":false,"created_at":"2020-01-15T08:32:41.000Z","display_name":"NEETzsche :iddqd:  ","emojis":[{"shortcode":"iddqd","static_url":"https://iddqd.social/emoji/iddqd/iddqd.png","url":"https://iddqd.social/emoji/iddqd/iddqd.png","visible_in_picker":false}],"fields":[],"follow_requests_count":1,"followers_count":322,"following_count":129,"fqn":"NEETzsche@iddqd.social","header":"https://iddqd.social/media/60309e1f8f235f782edb91b8920c2da3bef68899926d31ceff3c3bd40bae0255.jpg?name=1432089335401.jpg","header_static":"https://iddqd.social/media/60309e1f8f235f782edb91b8920c2da3bef68899926d31ceff3c3bd40bae0255.jpg?name=1432089335401.jpg","id":"9r1IDOZ3idEK4jk54K","locked":false,"note":"I&#39;m not actually a NEET. I worked my way through most of University and still have a job","pleroma":{"accepts_chat_messages":true,"allow_following_move":true,"also_known_as":[],"ap_id":"https://iddqd.social/users/NEETzsche","background_image":nil,"chat_token":"g2gDbQAAABI5cjFJRE9aM2lkRUs0ams1NEtuBgBgWmOWeAFiAAFRgA.8txyTT2f9NIOX7-sMdA9DLInUQIJ_dygDl0wp781lHg","deactivated":false,"favicon":nil,"hide_favorites":true,"hide_followers":false,"hide_followers_count":false,"hide_follows":false,"hide_follows_count":false,"is_admin":true,"is_confirmed":true,"is_moderator":false,"notification_settings":{"block_from_strangers":false,"hide_notification_contents":false},"relationship":{},"settings_store":{"soapbox_fe":{"chats":{"mainWindow":"minimized","panes":[]},"demetricator":false,"explanationBox":false,"frequentlyUsedEmojis":{"iddqd":1,"scream":1,"thinking_face":1},"notifications":{"quickFilter":{"active":"all"}},"otpEnabled":false,"themeMode":"dark"}},"skip_thread_containment":false,"tags":[],"unread_conversation_count":28,"unread_notifications_count":0},"source":{"fields":[],"note":"I'm not actually a NEET. I worked my way through most of University and still have a job","pleroma":{"actor_type":"Person","discoverable":false,"no_rich_text":false,"show_role":true},"privacy":"public","sensitive":false},"statuses_count":2697,"url":"https://iddqd.social/users/NEETzsche","username":"NEETzsche"}
      http_stub = HTTPStub::Stub.rig([example.to_json])
      syndesmos = Syndesmos.new(bearer_token: "Valid Token Here", instance: "example.com", api: HTTPStub)

      assert syndesmos.valid_credentials?
    end

    def test_invalid_bearer_token_invalid_credentials
      error = {"error":"Invalid credentials."}

      http_stub = HTTPStub::Stub.rig([error.to_json])
      syndesmos = Syndesmos.new(bearer_token: "Valid Token Here", instance: "example.com", api: HTTPStub)

      assert syndesmos.valid_credentials? == false
    end

    def test_can_login_with_username_password
      callback = {"client_id"=>"nsw7dGzcYi-eodTrIRIfcqHEqvjQiW9S7nw51PePfGc", "client_secret"=>"iZ7rzGDlwOw-PK2XgDcBFa0b0kJ8aG6lygYrsUwkXMs", "id"=>"76510", "name"=>"Syndesmos", "redirect_uri"=>"https://iddqd.social/oauth-callback", "website"=>nil, "vapid_key"=>"BP0fj7fMnrzMrKzaY8Ulu66RqVJhIhG93u0KAz90FGBWSvGMep0N2AG_oS-5bROJgC1uEjfn6aAhoTQVvlwA5w8"}
      token = {"access_token"=>"uo-xdkMiyJHU95UP1zpx_rlzdgjz8QupwqBa07JIkJs", "created_at"=>1617433475, "expires_in"=>3153600000, "me"=>"https://iddqd.social/users/NEETzsche", "refresh_token"=>"-TudxgMNUJUXH-Mvg8X5AzdhI96FCL5y5baZDSZV3bM", "scope"=>"read write follow push admin", "token_type"=>"Bearer"}
      example = {"acct":"NEETzsche","avatar":"https://iddqd.social/media/3f1b3b8abdc00351d2907df8a826e418ee1939b3b49954804fee848009fa004a.jpg?name=blob.jpg","avatar_static":"https://iddqd.social/media/3f1b3b8abdc00351d2907df8a826e418ee1939b3b49954804fee848009fa004a.jpg?name=blob.jpg","bot":false,"created_at":"2020-01-15T08:32:41.000Z","display_name":"NEETzsche :iddqd:  ","emojis":[{"shortcode":"iddqd","static_url":"https://iddqd.social/emoji/iddqd/iddqd.png","url":"https://iddqd.social/emoji/iddqd/iddqd.png","visible_in_picker":false}],"fields":[],"follow_requests_count":1,"followers_count":322,"following_count":129,"fqn":"NEETzsche@iddqd.social","header":"https://iddqd.social/media/60309e1f8f235f782edb91b8920c2da3bef68899926d31ceff3c3bd40bae0255.jpg?name=1432089335401.jpg","header_static":"https://iddqd.social/media/60309e1f8f235f782edb91b8920c2da3bef68899926d31ceff3c3bd40bae0255.jpg?name=1432089335401.jpg","id":"9r1IDOZ3idEK4jk54K","locked":false,"note":"I&#39;m not actually a NEET. I worked my way through most of University and still have a job","pleroma":{"accepts_chat_messages":true,"allow_following_move":true,"also_known_as":[],"ap_id":"https://iddqd.social/users/NEETzsche","background_image":nil,"chat_token":"g2gDbQAAABI5cjFJRE9aM2lkRUs0ams1NEtuBgBgWmOWeAFiAAFRgA.8txyTT2f9NIOX7-sMdA9DLInUQIJ_dygDl0wp781lHg","deactivated":false,"favicon":nil,"hide_favorites":true,"hide_followers":false,"hide_followers_count":false,"hide_follows":false,"hide_follows_count":false,"is_admin":true,"is_confirmed":true,"is_moderator":false,"notification_settings":{"block_from_strangers":false,"hide_notification_contents":false},"relationship":{},"settings_store":{"soapbox_fe":{"chats":{"mainWindow":"minimized","panes":[]},"demetricator":false,"explanationBox":false,"frequentlyUsedEmojis":{"iddqd":1,"scream":1,"thinking_face":1},"notifications":{"quickFilter":{"active":"all"}},"otpEnabled":false,"themeMode":"dark"}},"skip_thread_containment":false,"tags":[],"unread_conversation_count":28,"unread_notifications_count":0},"source":{"fields":[],"note":"I'm not actually a NEET. I worked my way through most of University and still have a job","pleroma":{"actor_type":"Person","discoverable":false,"no_rich_text":false,"show_role":true},"privacy":"public","sensitive":false},"statuses_count":2697,"url":"https://iddqd.social/users/NEETzsche","username":"NEETzsche"}

      HTTPStub::Stub.rig([callback.to_json, token.to_json, example.to_json])

      syndesmos = Syndesmos.new(username: "NEETzsche", password: "My Password", instance: "iddqd.social", api: HTTPStub)
      assert syndesmos.valid_credentials?
    end

    def test_cant_login_with_bad_password
      callback = {"client_id"=>"nsw7dGzcYi-eodTrIRIfcqHEqvjQiW9S7nw51PePfGc", "client_secret"=>"iZ7rzGDlwOw-PK2XgDcBFa0b0kJ8aG6lygYrsUwkXMs", "id"=>"76510", "name"=>"Syndesmos", "redirect_uri"=>"https://iddqd.social/oauth-callback", "website"=>nil, "vapid_key"=>"BP0fj7fMnrzMrKzaY8Ulu66RqVJhIhG93u0KAz90FGBWSvGMep0N2AG_oS-5bROJgC1uEjfn6aAhoTQVvlwA5w8"}
      token = {"access_token"=>"uo-xdkMiyJHU95UP1zpx_rlzdgjz8QupwqBa07JIkJs", "created_at"=>1617433475, "expires_in"=>3153600000, "me"=>"https://iddqd.social/users/NEETzsche", "refresh_token"=>"-TudxgMNUJUXH-Mvg8X5AzdhI96FCL5y5baZDSZV3bM", "scope"=>"read write follow push admin", "token_type"=>"Bearer"}
      error = {"error":"Invalid credentials."}

      HTTPStub::Stub.rig([callback.to_json, token.to_json, error.to_json])

      syndesmos = Syndesmos.new(username: "NEETzsche", password: "Not My Password", instance: "iddqd.social", api: HTTPStub)
      assert syndesmos.valid_credentials? == false
    end
  end
end