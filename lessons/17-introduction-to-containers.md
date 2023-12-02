---
title: Introduction to Containers
---

## Agenda

- What are Containers?
- Open Container Initiative
- How to define Containers?
- Common Commands

---

## What are Containers?

<aside class="notes">
    Lets start to talk about what containers actually are.
</aside>

---

## Visualization

![](../assets/L14-container.png){ width=65% }

<aside class="notes">
    You should already be familiar with this picture from one of the last
    presentations. If you deploy a single application onto one server you will
    almost never be able to use the full potential of the server. Through a
    container engine you are able many applications isolated from each other
    ontop of a single operating system. But lets first talk about the definition
    of containers.
</aside>

---

## Definition of Containers

- Package of Software and its Dependencies
- Run in any Environment
- Container Images become Containers
- Run on a Container Engine
- Virtualize Operating Systems

<aside class="notes">
    A container can be defined as a package of software and its dependencies
    that can be run in any environment. Independent of in a data center, a
    desktop pc or a laptop. These containers are defined through container
    images which when execute then become containers. The executuion is done on
    a so called container engine. In this course you already got in touch with
    Docker and Podman. These are two different tools that let you interact with
    container engines. Another important thing to understand is that containers
    do not virtualize hardware but the operating system. Because of that each
    container only needs the applications and the required libraries and through
    that are pretty lightweight.
</aside>

---

## How to define Containers?

- File with Instructions
- Layers of Files (binaries, code, dependencies)
- Immutable
- Container Images

<aside class="notes">
    We quickly mentioned container images and that they define how a container
    will run. But what does this mean? A container image can be built with the
    help of a Containerfile. This Containerfile contains instructions on how to
    accumulate the different files and binaries that are required for your
    application to run. Almost each step in your instructions leads to a new
    layer within the container image. These layers are immutable this means can
    not be changed. These layers can then also be shared amongst container and
    improve build speeds. An archive of the combined layers is then the
    container image. As soon as it is started and turned into a container a new
    layer is added which is not readonly.
</aside>

---

## Containerfile Example 1

```Dockerfile
FROM alpine:latest
LABEL dev.zhews.description="Example"
RUN echo "Hello World!"
EXPOSE 80
ENV ORG="Powercoders"
WORKDIR /run
COPY file /run/file
ADD http://example.com/big.tar.gz /run/big
USER 1000
ENTRYPOINT ["/run/file"]
CMD ["-p", "80"]
```

<aside class="notes">
    Lets take a look at how these instructions could look like. Be aware that
    this example is nothing like in production and just to show what kind of
    instructions there are. With the first instruction you define that you want
    to use the layers of the container image alpine with version latest as a
    basis. After that you provide some metadata with the key
    "dev.zhews.description" and the value "Example". The RUN instruction allows
    you to run a command within the build process of the container. In this case
    the echo command. After that comes a instruction that is used for
    documentation. It tells you that this image will provide a network service
    on port 80 meaning HTTP. The ENV instruction defines an environmental
    variable within the container. In this case ORG is "Powercoders". Then you
    tell it that the directory all the following instructions should be executed
    in is /run. With the COPY instruction you copy the file named file on your
    local system to /run/file within the container. With the add command you
    fetch and extract the archive named big into the folder big under the
    directory /run in the container. Then you tell that from know on everthing
    should be executed as user with id 1000. In the end you tell the image what
    to execute. In this specific case /run/file and with the CMD instruction you
    provide the argument -p with value 80.
</aside>

---

## Containerfile Example 2.1

```Dockerfile
FROM golang:1.21 AS build

WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY main.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /build/bin/example
```

<aside class="notes">
    As the example from before was quite overkill lets take a look at a more
    real life example. This example is distributed across two slides but is a
    single instructions file. These files btw are usually called "Containerfile"
    or "Dockerfile". As a first instruction you tell the container image to use
    the container image golang with version 1.21 as a basis. This layer should
    be accessible under the name build. After that you want to execute all the
    commands within the /build directory. With the following command you copy
    the go related files that contain the links to external dependencies and
    then with the next instruction install them within the container. After this
    step you copy the main application logic into the container and then build
    the application into the folder /build/bin/example. What you can see here as
    well is the good usage of the layer caching. As long as your dependencies do
    not change you will not have to rerun the first 4 steps again.
</aside>

---

## Containerfile Example 2.2

```Dockerfile
FROM gcr.io/distroless/static-debian12:nonroot AS run

WORKDIR /run
COPY --from=build /build/bin/example /run/example

USER nonroot:nonroot

ENTRYPOINT ["/run/example"]

EXPOSE 8080
```

<aside class="notes">
    In a second set of instructions you tell that you know want to switch to a
    different container image as a basis. In there you again switch the working
    directory into this time /run. Now there comes a more advanced feature you
    copy the file /build/bin/example from the previous build basis into the new
    run basis under /run/example. Then you switch the user and group within the
    name basis or stage to nonroot and nonroot. You then configure the
    entrypoint to be /run/example. At the end you added some documentation about
    the port the application will expose.
</aside>

---

## Open Container Initiative

- Governance Structure
- Standards around Container Formats and Runtimes
- Different Tools same Thing

<aside class="notes">
    We have also talked about the fact that you are able to use different
    software to interact with the container engines. This is because of a thing
    called the open container initiative (OCI). This initiative is a governance
    structure which makes sure there are some standards for everything related
    to containers. A good example is standards around the format and runtimes of
    container and their images. Almost every big container engine follows these
    standards which leads to you being having the same interface almost
    everywhere. Or in other words different tool same thing.
</aside>

---

## Common Commands

<aside class="notes">
    Now lets look at some common ways on how to interact with the container
    engine.
</aside>

---

## Listing

```bash
podman ps --all # list all local containers
podman images   # list all local container images
```

<aside class="notes">
    Lets start with listing things. The first command can be used to show all
    the containers that are present on the engine even the ones that have been
    stopped. The second command shows you all the container images that are
    currently present on the system.
</aside>

---

## Fetching

```bash
podman pull python
podman pull golang
podman pull alpine
```

<aside class="notes">
    If you want to fetch a container image you can do that with the pull
    subcommand. In this example we fetch the images of python, golang and alpine
    linux. This will fetch the images from a artifact registry a thing we have
    covered already.
</aside>

---

## Building

```bash
podman build -t tag:version -f Containerfile .
```

<aside class="notes">
    If you have defined a set of instruction for your application as well you
    can build it with the help of the build subcommand. The -t flag is to give
    your container image a specific tag with a version. With the -f flag you can
    tell where the client will be able to find the instructions to build the
    image. In the end you will have to provide the context or in other words the
    place where all the commands will be executed.
</aside>

---

## Running

```bash
podman run alpine:latest sleep 10 # sleep 10 seconds in alpine
podman run -d -p 8080:80 nginx:latest # run nginx detached and forward port
podman run -v $PWD/app/data:/app/data app:latest # run app with a mounted volume
```

<aside class="notes">
    If you have some images present you are then able to run them with the run
    subcommand. In the first example you run the image alpine with version
    latest and provide the sleep command as entrypoint. On the second command
    you tell podman to run the nginx image with version latest which is a web
    server to run with the default entrypoint but expose port 80 within the
    container on your system on port 8080. The -d flag detaches the container
    from your current terminal session. In the last example you run the
    container image app with version latest and mount the app/data directory in
    your local filesystem to /app/data within the container.
</aside>

---

## Stopping

```bash
podman stop container-id # gracefully stop a container
podman kill container-id # force container stop
```

<aside class="notes">
    If you then want to stop the container again you can use the stop subcommand
    to gracefully stop the container. This means to let the application do its
    shutdown stuff like finish open requests and so on. If it has to be
    immediatly you can use the kill subcommand.
</aside>

---

## Deleting

```bash
podman rm container-id # delete a stopped container
podman rmi image-name  # delete a container image
```

<aside class="notes">
    In case you dont need a container any more you can remove it with the rm
    subcommand. As you still have the container image you will always be able to
    rerun it again. In case you want to remove the container image you can use
    the rmi subcommand.
</aside>

---

## Pushing

```bash
podman login quay.io                 # login to a registry
podman push quay.io/zhews/app:latest # push image to registry
```

<aside class="notes">
    If you then want to share some container images with other people you can
    push them to a container registry. In almost all cases you will first have
    to login. Then you can push images to the registry. The images need to have
    the prefix of your registry within the tag.
</aside>

---

## Logs

```Dockerfile
podman logs container-id    # get logs of container
podman logs -f container-id # follow the logs of the container
```

<aside class="notes">
    If something goes wrong you would want to look at the logs that accumulated
    within the container. To do that you can use the logs subcommand. In case
    you want to also see newly incoming logs use the -f flag.
</aside>

---

## Execute

```bash
podman exec container-id ls       # execute ls in the container
podman exec -it container-id bash # start a shell in the container
```

<aside class="notes">
    Sometimes you want to execute commands within the running container. To do
    that you can use the exec subcommand. In the first example you just run a
    simple command and will see the output within terminal. If you want to
    interactively execute commands you can execute a shell within the container.
    You will have to provide the -i flag for interactivity and -t flag to spawn
    an environment for the shell.
</aside>

---

## Copy

```bash
podman cp container-id-1:/app container-id-2:/app # copy file between containers
podman cp file container-id:/app/file # copy file into container
podman cp container-id:/app/file file # copy file from container
```

<aside class="notes">
    Sometimes you maybe want to access files within the container as well. To do
    that you can use the cp subcommand. In the first example you copy a file
    from container 1 to container 2. In the second example you copy a local file
    into a container. In the last example you copy a file from within the
    container into your local system.
</aside>

---

## Compose

```bash
podman compose up -d
podman compose down
```

<aside class="notes">
    Compose is a tool for defining and running multi-container applications.
    With Compose, you use a YAML file to configure your application's services.
    Then, with a single command, you create and start all the services from your
    configuration.
</aside>

---

## Compose File

```yaml
version: "3"
services:
  web:
    build: .
    ports:
      - "8080:80"
    volumes:
      - app/data:/app/data
    environment:
      DEFAULT_NAME: "World"
  redis:
    image: "redis:alpine"
```

<aside class="notes">
    In this specific example you defined two containers. The first container
    uses the current working directory as context to build the container image
    and publishes port 80 of the container on 8080 of the host. It also mounts a
    volume from the local file system on /app/data in the container. Finally the
    first container gets an environmental variable. The second container has no
    additional configuration and will just be pulled from the registry.
</aside>
