dev_bash:
	dip run bash
dev_web:
	dip run web

# production
build:
	docker-compose up -d --build
