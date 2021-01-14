
## Link shortener
Hi there, this is my link shortner project. I have done a short writeup for
this project, you can check it out [here](http://breen.ie/link-shortener-part-1/).

To setup the project on your own machine follow the steps below

##### Prerequisites


The setups steps expect following tools installed on the system.

- Github
- Ruby [2.6.1](https://www.ruby-lang.org/en/)
- Rails [6.0.3](https://rubyonrails.org/)

##### 1. Check out the repository

```bash
git clone git@github.com:conorbr/url_shortener.git
```

##### 2. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```

##### 3. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can make requests to the the site with the URL http://localhost:3000
