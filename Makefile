-include ../aaf-terraform/Makefile

up:
	docker-compose up -d
	@echo "jekyll site is running at http://localhost:4000"

down:
	docker-compose down
lint:
	markdownlint-cli2 --fix "docs/**/*.md"  "!docs/assets/**" "!docs/_sass/**"