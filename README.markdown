# rhetoric

# Installing

## Creating your first user

* rake auth:gen:site_key # to create config/initializer/site_keys.rb
* hit /signup and create your user
* from the console u=User.find(1) ; u.activate ; u.name="Your Name" ; u.save
* if you're only going to have the one user, you can remove the routes
* no login link provided, just hit it directly