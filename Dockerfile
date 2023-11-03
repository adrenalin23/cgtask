# Use an official Ruby runtime as a parent image
FROM ruby:2.7.8

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

# Set the working directory in the container
WORKDIR /app

# Install Rails and other dependencies
RUN gem install rails -v 6.0.4.1

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install the application's gems
RUN bundle install
RUN yarn install

# Copy the application code to the container
COPY . .
RUN rm -rf node_modules vendor

#RUN rails webpacker:install

# Expose a port, if needed (e.g., for a development server)
# EXPOSE 3000

# Start the Rails application
# CMD ["rails", "server", "-b", "0.0.0.0"]
CMD bundle exec unicorn -c config/unicorn.rb
