-include ../aaf-terraform/Makefile

up:
	RUBY_VERSION="$$(cat docs/.ruby-version)" docker-compose up -d
	@echo "jekyll site is running at http://localhost:4000"
tutorial:
	@test -n "$(TITLE)" || (echo 'Usage: make tutorial TITLE="Title of my new tutorial"'; exit 1)
	RUBY_VERSION="$$(cat docs/.ruby-version)" docker-compose run --rm --no-deps -T --user "$$(id -u):$$(id -g)" jekyll ruby _rake/tutorial.rb "$(TITLE)"
run:
	cd docs && \
	bundle install && \
	bundle exec rake setup && \
	bundle exec rake preview
down:
	RUBY_VERSION="$$(cat docs/.ruby-version)" docker-compose down
lint:
	cd docs && \
	rake lint