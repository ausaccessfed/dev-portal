-include ../aaf-terraform/Makefile

up:
	docker-compose up -d
	@echo "jekyll site is running at http://localhost:4000"
run:
	cd docs && \
	bundle install && \
	bundle exec rake setup && \
	bundle exec rake preview
down:
	docker-compose down
lint:
	cd docs && \
	rake markdown_lint