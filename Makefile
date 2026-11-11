-include ../aaf-terraform/Makefile

up:
	RUBY_VERSION="$$(cat docs/.ruby-version)" docker-compose up -d
	@echo "jekyll site is running at http://localhost:4000"
tutorial:
	bash bin/create_tutorial.sh "$(TITLE)"
update-last-modified:
	bash bin/update_last_modified_in_docker.sh
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