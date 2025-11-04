up:
	docker-compose up -d
	@echo "jekyll site is running at http://localhost:4000"

down:
	docker-compose down


deploy:
	./deploy.sh REMOTE_MAIN_BRANCH=main
	@echo "Site deploying to GitHub Pages. Check the repository for updates."