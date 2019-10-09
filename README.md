srs
===

CentOS docker for [SRS](https://github.com/ossrs/srs) developer.

## Usage

**Install docker**

Download docker from [here](https://www.docker.com/products/docker-desktop) then start docker.

**Build docker image**

```
docker pull ossrs/dev
```

> Remark: For CentOS6, please pull `ossrs/dev6` instead, other iamges are [here](https://hub.docker.com/r/ossrs/dev/tags).

**Clone SRS**

```
git clone https://github.com/ossrs/srs.git && cd srs
```

**Start docker**

```
docker run -it -v `pwd`:/tmp/srs -w /tmp/srs/trunk -p 1935:1935 \
  -p 1985:1985 -p 8080:8080 -p 8085:8085 ossrs/dev bash
```

**Build SRS in docker**

```
./configure && make
```

**Run SRS in docker**

```
./objs/srs -c conf/console.conf
```

## EXEC

To enter your container:

```
dockerID=`docker ps --format "{{.ID}} {{.Image}}" |grep 'ossrs/dev' |awk '{print $1}'` &&
docker exec -it $dockerID bash
```

## GDB

To run docker with `--privileged` for GDB, or it fail for error `Cannot create process: Operation not permitted`.

## Api Server

To run api-server at 8085 in docker:

```
(cd objs/CherryPy-3.2.4 && python setup.py install --user) &&
python research/api-server/server.py 8085
```

## Features

- [x] v0.1, NetTools, GDB, OpenSSL 1.1.0e, FFMPEG 4.1 with x264 core.157, GIT
