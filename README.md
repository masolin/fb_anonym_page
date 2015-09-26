# FB Anonym Page

Facebook become the biggest social platform. Most people spend lots of time on it.
However, facebook is a real-name system. People cannot post anonymous comments
directly.

This Rails app allow that people publish anonymous comments to facebook page.
At the back-end, admin can change app setting to allow that user publish posts
directly to facebook page or not.
If admin disable auto-post function, posts need to be reviewed by admin.

The app would not store IP or other user information in database. It only store
content of posts.

## Demo

* Demo site: https://fb-anonym-page.herokuapp.com

* Demo facebook test page: https://www.facebook.com/Anonym-Test-Page-715425985259271/

### Front-end screenshot

![screenshot-frontend](/app/assets/images/screenshot_front.png)

### Back-end screenshots

![screenshot-backend-posts](/app/assets/images/screenshot_backend_posts.png)

![screenshot-backend-setting](/app/assets/images/screenshot_backend_setting.png)


## Technique Keywords

* CSS: materialize-sass, font-awesome
* JS: jquery-turbolinks
* Setting: rails-settings-cached
* OAuth: omniauth-facebook
* Facebook graph api: koala
* Service Object

## Contributing

1. [Fork it](https://github.com/masolin/fb_anonym_page/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
