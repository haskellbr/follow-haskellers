# follow-haskellers
[![Build Status](https://travis-ci.org/haskellbr/follow-haskellers.svg?branch=master)](https://travis-ci.org/haskellbr/follow-haskellers)
- - -
Follow potential Haskellers on Twitter.

## Usage
```
$ follow-haskellers
[tweet] "Eu amo Haskell!"
[follow] Following haskeller1234
```

## Configuration
The following environment variables must be set:

- "TWITTER_API_KEY"
- "TWITTER_API_SECRET"
- "TWITTER_OAUTH_TOKEN"
- "TWITTER_OAUTH_TOKEN_SECRET"

## Binary distribution
The Travis CI service builds this repository on every commit and uploads
produced binaries to Amazon S3. You can download a compressed Linux 64-bit
static binary for this application from
[here](http://haskellbr.com.s3-website-sa-east-1.amazonaws.com/follow-haskellers/follow-haskellers.bz2).

## Docker distribution
This repository provides an easy way to download this static binary and produce
a working docker image.

**It's roughly 20MB in size, though it could be smaller.**

The image is uploaded the Docker Hub as
[`haskellbr/follow-haskellers`](https://hub.docker.com/r/haskellbr/follow-haskellers/)
and tagged with the current commit hash. The latest commit's image is always
tagged with `latest`.

You can run the docker container with:
```
$ docker run -it -e "configuration variables..." haskellbr/follow-haskellers
```

To generate a docker image run:
```
$ make docker-image
```

To push it run:
```
$ make docker-push-image
```

## License
This code is published under the MIT license.
