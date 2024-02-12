build-image:
	docker build . -t dev-portal
	
run-image:
	docker run -p 4000:4000 dev-portal