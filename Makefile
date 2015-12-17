docker-image:
	curl http://haskellbr.com.s3-website-sa-east-1.amazonaws.com/follow-haskellers/follow-haskellers.bz2 > follow-haskellers.bz2
	bzip2 -d follow-haskellers.bz2
	chmod +x follow-haskellers
	docker build .
