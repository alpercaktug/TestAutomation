# Use an official Ruby runtime as a parent image
FROM ruby:3.2.0

# Set up working directory
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock into the image
COPY Gemfile* ./

# Install gems
RUN bundle install

# Copy the rest of your application code
COPY . .

# Provide default environment variables
ENV TAGS=@smoke ENV=prod PLATFORM=browserstack

# Set entrypoint
ENTRYPOINT ["rake", "run"]

# Expose port 8080 (if your tests are run on a server that uses this port)
EXPOSE 8080
