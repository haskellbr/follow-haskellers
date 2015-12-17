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

## Binary distribution
The Travis CI service builds this repository on every commit and uploads
produced binaries to Amazon S3. You can download a Linux 64-bit static binary
for this application from
[here](http://haskellbr.com.s3-website-sa-east-1.amazonaws.com/follow-haskellers/follow-haskellers.bz2).

## Configuration
The following environment variables must be set:

- "TWITTER_API_KEY"
- "TWITTER_API_SECRET"
- "TWITTER_OAUTH_TOKEN"
- "TWITTER_OAUTH_TOKEN_SECRET"

## License
This code is published under the MIT license.
