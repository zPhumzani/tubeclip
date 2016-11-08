# Tubeclip

Ok! Lets say there is a awesome ruby gem you want to use in your project and it haven't been updated for a long time. This is a ruby 2.3.1 and rails 5 updated version of [youtube_it](https://github.com/kylejginavan/youtube_it).

tubeclip is the most complete Ruby client for the YouTube GData API. It provides an easy way to access the latest and most complete access to YouTube's video API. In comparison with the earlier Youtube interfaces, this new API and library offers much-improved flexibility around executing complex search queries to obtain well-targeted video search results.  In addition, standard video management  including but not limited to uploading, deleting, updating, like, dislike, ratings and comments.
  
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tubeclip'
```

And then execute:

    
    $ bundle

Or install it yourself as:

    
    $ gem install tubeclip

Note: Do forget to create a youtube account, create a developer key here http://code.google.com/apis/youtube/dashboard and tubeclip supports ClientLogin(YouTube account), OAuth or AuthSub authentication methods.

## DEMO

You can checkout this [**SitePoint** Youtube on rails tutorial](https://www.sitepoint.com/youtube-rails/) .
Please use tubeclip gem or just use [youtube_it](https://github.com/kylejginavan/youtube_it) gem and rails 3/4
 
## ESTABLISHING A CLIENT

Important: The Account Authentication API for OAuth 1.0, AuthSub and Client Login has been officially deprecated as of April 20, 2012. It will continue to work as per our deprecation policy(https://developers.google.com/accounts/terms), but we encourage you to migrate to OAuth 2.0 authentication as soon as possible. If you are building a new application, you should use OAuth 2.0 authentication.

Creating a client:

    $ require 'tubeclip'
    $ client = Tubeclip::Client.new

Client with developer key:

    $ client = Tubeclip::Client.new(:dev_key => "developer_key")
    
Client with youtube account and developer key:

    $ client = Tubeclip::Client.new(:username => "youtube_username", :password =>  "youtube_passwd", :dev_key => "developer_key")

Client with AuthSub:

    $ client = Tubeclip::AuthSubClient.new(:token => "token" , :dev_key => "developer_key")

Client with OAuth:

    $ client = Tubeclip::OAuthClient.new("consumer_key", "consumer_secret", "youtube_username", "developer_key")
    $ client.authorize_from_access("access_token", "access_secret")

Client with OAuth2:

    $ client = Tubeclip::OAuth2Client.new(client_access_token: "access_token", client_refresh_token: "refresh_token", client_id: "client_id", client_secret: "client_secret", dev_key: "dev_key", expires_at: "expiration time")

If your access token is still valid (be careful, access tokens may only be valid for about 1 hour), you can use the client directly. If you want to refresh the access token using the refresh token just do:

    $ client.refresh_access_token!

* You can see more about oauth 2 in the wiki: https://github.com/kylejginavan/tubeclip/wiki/How-To:-Use-OAuth-2

## PROFILES
  you can use multiple profiles in the same account like that

    $ profiles = client.profiles(['username1','username2']) 
    $ profiles['username1'].username, "username1"

## VIDEO QUERIES

Note:  Each type of client enables searching capabilities.

Basic Queries:

    $ client.videos_by(:query => "penguin")
    $ client.videos_by(:query => "penguin", :page => 2, :per_page => 15)
    $ client.videos_by(:query => "penguin", :restriction => "DE")
    $ client.videos_by(:query => "penguin",  :author => "liz")
    $ client.videos_by(:tags => ['tiger', 'leopard'])
    $ client.videos_by(:categories => [:news, :sports])
    $ client.videos_by(:categories => [:news, :sports], :tags => ['soccer', 'football'])
    $ client.videos_by(:user => 'liz')
    $ client.videos_by(:favorites, :user => 'liz')
    $ client.video_by("FQK1URcxmb4")
    $ client.video_by("https://www.youtube.com/watch?v=QsbmrCtiEUU")  
    $ client.video_by_user("chebyte","FQK1URcxmb4")

Standard Queries:

    $ client.videos_by(:most_viewed)
    $ client.videos_by(:most_linked, :page => 3)
    $ client.videos_by(:top_rated, :time => :today)
    $ client.get_all_videos(:top_rated, :time => :today)
    $ client.videos_by(:top_rated,  :region => "RU", :category => "News")
Advanced Queries (with boolean operators OR (either), AND (include), NOT (exclude)):
    $ client.videos_by(:categories => { :either => [:news, :sports], :exclude => [:comedy] }, :tags => { :include => ['football'], :exclude => ['soccer'] })


Custom Query Params
 You can use custom query params like that:

    $ client.videos_by(:query => "penguin", :safe_search => "strict")
    $ client.videos_by(:query => "penguin", :duration => "long")
    $ client.videos_by(:query => "penguin", :hd => "true")
    $ client.videos_by(:query => "penguin", :region => "AR")

 you can see more options here https://developers.google.com/youtube/2.0/reference#yt_format

Fields Parameter(experimental features):
  Return videos more than 1000 views

    $ client.videos_by(:fields => {:view_count => "1000"})

  Filter by date

    $ client.videos_by(:fields => {:published  => (Date.today)})
    $ client.videos_by(:fields => {:recorded   => (Date.today)})  

  Filter by date with range

    $ client.videos_by(:fields => {:published  => ((Date.today - 30)..(Date.today))})
    $ client.videos_by(:fields => {:recorded   => ((Date.today - 30)..(Date.today))})  
  
Note: These queries do not find private videos! Use these methods instead:

    $ client.my_video("FQK1URcxmb4")
    $ client.my_videos(:query => "penguin")

## VIDEO MANAGEMENT

Note: YouTube account, OAuth or AuthSub enables video management.

Upload Video:

    $ client.video_upload(File.open("test.mov"), :title => "test",:description => 'some description', :category => 'People',:keywords => %w[cool blah test])

Upload Remote Video:

    $ client.video_upload("http://url/myvideo.mp4", :title => "test",:description => 'some description', :category => 'People',:keywords => %w[cool blah test])


Upload Video With A Developer Tag (Note the tags are not immediately available):

    $ client.video_upload(File.open("test.mov"), :title => "test",:description => 'some description', :category => 'People',:keywords => %w[cool blah test], :dev_tag => 'tagdev')

Upload Video from url:

    $ client.video_upload("http://media.railscasts.com/assets/episodes/videos/412-fast-rails-commands.mp4", :title => "test",:description => 'some description', :category => 'People',:keywords => %w[cool blah test])

Upload Private Video:

    $ client.video_upload(File.open("test.mov"), :title => "test",:description => 'some description', :category => 'People',:keywords => %w[cool blah test], :private => true)


Update Video:

    $ client.video_update("FQK1URcxmb4", :title => "new test",:description => 'new description', :category => 'People',:keywords => %w[cool blah test])

Delete Video:

    $ client.video_delete("FQK1URcxmb4")

My Videos:

    $ client.my_videos

My Video:

    $ client.my_video(video_id)

Profile Details:

    $ client.profile(user) #default: current user

List Comments:

    $ client.comments(video_id)

Add A Comment:

    $ client.add_comment(video_id, "test comment!")

Add A Reply Comment:

    $ client.add_comment(video_id, "test reply!", :reply_to => another_comment)

Delete A Comment:

    $ client.delete_comment(video_id, comment_id)

List Favorites:

    $ client.favorites(user) # default: current user

Add Favorite:

    $ client.add_favorite(video_id)

Delete Favorite:

    $ client.delete_favorite(favorite_entry_id)

Like A Video:

    $ client.like_video(video_id)

Dislike A Video:

    $ client.dislike_video(video_id)

List Subscriptions:

    $ client.subscriptions(user) # default: current user

Subscribe To A Channel:

    $ client.subscribe_channel(channel_name)

Unsubscribe To A Channel:

    $ client.unsubscribe_channel(subscription_id)

List New Subscription Videos:

    $ client.new_subscription_videos(user) # default: current user
  
List Playlists:

    $ client.playlists(user, order_by) # default: current user, position

  for example you can get the videos of your playlist ordered by title

    $ client.playlists(user, "title")

  you can see more about options for order_by here: https://developers.google.com/youtube/2.0/reference#orderbysp

Select Playlist:

    $ client.playlist(playlist_id)

Select All Videos From A Playlist:

    $ playlist = client.playlist(playlist_id)
    $ playlist.videos

Create Playlist:

    $ playlist = client.add_playlist(:title => "new playlist", :description => "playlist description")

Delete Playlist:

    $ client.delete_playlist(playlist_id)

Add Video To Playlist:

    $ client.add_video_to_playlist(playlist_id, video_id, position)

Remove Video From Playlist:

    $ client.delete_video_from_playlist(playlist_id, playlist_entry_id)

Update Position Video From Playlist:

    $ client.update_position_video_from_playlist(playlist_id, playlist_entry_id, position)

Select All Videos From your Watch Later Playlist:

    $ watcher_later = client.watcherlater(user) #default: current user
    $ watcher_later.videos

Add Video To Watcher Later Playlist:

    $ client.add_video_to_watchlater(video_id)

Remove Video From Watch Later Playlist:

    $ client.delete_video_from_watchlater(watchlater_entry_id)


List Related Videos

    $ video = client.video_by("https://www.youtube.com/watch?v=QsbmrCtiEUU&feature=player_embedded")
    $ video.related.videos

Add Response Video

    $ video.add_response(original_video_id, response_video_id)

Delete Response Video

    $ video.delete_response(original_video_id, response_video_id)

List Response Videos

    $ video = client.video_by("https://www.youtube.com/watch?v=QsbmrCtiEUU&feature=player_embedded")
    $ video.responses.videos

  
## BATCH VIDEOS
you can list many videos at the same time

    $ client.videos(['video_id_1', 'video_id_2',...])


## ACCESS CONTROL LIST

  You can give permissions in your videos, for example denied comments, rate, etc...
  you can read more there http://code.google.com/apis/youtube/2.0/reference.html#youtube_data_api_tag_yt:accessControl
  you have available the followings options:

* :rate, :comment, :commentVote, :videoRespond, :list, :embed, :syndicate

  with just two values:
*    allowed or denied

  Example

  client = Tubeclip::Client.new(:username => "youtube_username", :password =>  "youtube_passwd", :dev_key => "developer_key")

* upload video with denied comments

  client.video_upload(File.open("test.mov"), :title => "test",:description => 'some description', :category => 'People',:keywords => %w[cool blah test], :comment => "denied")

## Partial Updates
  You can send a single PATCH request to add, replace and/or delete specific fields for a particular resource.

  client.video_partial_update(video.unique_id, :list => 'denied', :embed => 'allowed')

## User Activity
 You can get user activity with the followings params:
 
 $ client.activity(user) #default current user
 
## Video Upload From Browser:

When uploading a video from your browser you need make a form upload with the followings params:
    $ upload_token(params, nexturl)
params  => params like :title => "title", :description => "description", :category => "People", :keywords => ["test"]
nexturl => redirect to this url after upload


Controller
  def upload
    @upload_info = Tubeclip::Client.new.upload_token(params, videos_url)
  end

View (upload.html.erb)
  <% form_tag @upload_info[:url], :multipart => true do %>
    <%= hidden_field_tag :token, @upload_info[:token] %>
    <%= label_tag :file %>
    <%= file_field_tag :file %>
    <%= submit_tag "Upload video" %>
  <% end %>

## WIDESCREEN VIDEOS

If the videos has support for widescreen:
    $ video.embed_html_with_width(1280)

Note: you can specify width or just use the default of 1280.

## USING HTML5

Now you can embed videos without use flash using html5, usefull for mobiles that not support flash but has html5 browser

You can specify these options
    $ video.embed_html5({:class => 'video-player', :id => 'my-video', :width => '425', :height => '350', :frameborder => '1', :url_params => {:option_one => "value", :option_two => "value"},
  fullscreen: true, :sandbox => "value"})

or just use with default options
    $ video.embed_html5 #default: width: 425, height: 350, frameborder: 0

## LOGGING

Tubeclip passes all logs through the logger variable on the class itself. In Rails context, assign the Rails logger to that variable to collect the messages
(don't forget to set the level to debug):
    $ Tubeclip.logger = RAILS_DEFAULT_LOGGER
    $ RAILS_DEFAULT_LOGGER.level = Logger::DEBUG

## RUBY INTERPRETER COMPABILITY:

  * 2.3.1

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT)


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zPhumzani/tubeclip. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.