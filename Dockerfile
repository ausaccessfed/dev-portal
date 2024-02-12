FROM ruby:3.1-slim-bullseye as base

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git && \
    rm -rf /var/lib/apt/lists/*

# Use bundle config to skip installation of documentation
RUN bundle config --global frozen 1 && \
    bundle config --global quiet true

# Copy entrypoint script
COPY bin/entrypoint.sh /usr/local/bin/

RUN gem update --system && \
    gem install jekyll && \
    gem cleanup

EXPOSE 4000

# Copy docs directory
COPY docs docs
WORKDIR /docs

# Metadata
LABEL maintainer="@aaf.edu.au"
LABEL description="Docker image for serving Jekyll site"

# Build from the image
FROM base as jekyll-serve


# On every container start, check if Gemfile exists and warn if it's missing
ENTRYPOINT [ "entrypoint.sh" ]

CMD [ "bundle", "exec", "jekyll", "serve", "--force_polling", "-H", "0.0.0.0", "-P", "4000" ]
