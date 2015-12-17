docker-image:
	rm -f follow-haskellers
	curl http://haskellbr.com.s3-website-sa-east-1.amazonaws.com/follow-haskellers/follow-haskellers.bz2 > follow-haskellers.bz2
	bzip2 -d follow-haskellers.bz2
	chmod +x follow-haskellers
	docker build -t haskellbr/follow-haskellers:`git rev-parse HEAD` .
	docker tag haskellbr/follow-haskellers:`git rev-parse HEAD` haskellbr/follow-haskellers:latest

docker-push-image:
	docker push haskellbr/follow-haskellers:`git rev-parse HEAD`
	docker push haskellbr/follow-haskellers:latest
