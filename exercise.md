# Exercise

## 1. Preparing your Device

The following tools are used in this exercise:

- `git`
- `gh` (optional)
- `python`
- `pip`
- `black`
- `pylint`
- `go`
- `golangci-lint`
- `virtualbox`
- `podman`
- `podman-compose`
- `k3s`
- `kubectl`
- `aws-cli`
- `opentofu`
- `ansible`

Install them with the instructions for your kind of device on the official
websites.

## 2. Create GitHub Project

In this exercise you will create projects on GitHub where you are able to
track your work with the help of a kanban board.

1. Open [GitHub](https://github.com/) and login with your existing account
2. Click on the plus sign in the upper right corner and select "New project"
3. Select the "Board" template on the left side
4. Change the project name above the picture to "Powercoders DevOps Track"
5. Click on "Create"

You will now see three columns: "Todo", "In Progress" and "Done".

For each task that you receive from now on create a draft in the "Todo" column
by clicking "Add item" at the bottom of the column and describing the task in a
couple of words. After that click on the newly created task and change the
description to the following: "As a USER I want FUNCTIONALITY so that BENEFIT".
Replace USER with the kind of user that would like this task to be done. This
could be a developer, quality assurance, a customer and so on. Replace
FUNCTIONALITY with the thing you want to achieve through this task. This could
be a new button on a website, an automation, changing a sentence and so on.
Finally, replace BENEFIT with why this task should be done. This could be less
manual work, improved user experience, less resource usage and so on. This is
done to articulate how the task will deliver back value to a customer.

Optional: The same thing could have been done with the following GitHub CLI
command.

```shell
gh project create --owner "@me" --title "Powercoders DevOps Track"
```

## 3. Create Repositories

During this track you will create two applications in different programming
languages to help you understand the different concepts. To store the source
code of these applications you will use [GitHub](https://github.com). In this
exercise you will create the two repositories for the applications.

1. Open [GitHub](https://github.com/) and login with your existing account
2. Click on the plus sign in the upper right corner and select "New repository"
3. Change the "Repository name" to "docker-workflowpygreeter"
4. Change the "Description" to "Simple Greeting REST API in Python"
5. Leave the rest as it is and click "Create repository" on the bottom right
6. Repeat these steps with "gogreeter" as "Repository name" and "Simple
   Greeting REST API in Go"

Think about the branching strategy and structure of commits you want to use.

Optional: The same thing could have been done with the following GitHub CLI
commands.

```shell
gh repo create pygreeter -d "Simple Greeting REST API in Python" --public
gh repo create gogreeter -d "Simple Greeting REST API in Go" --public
```

## 4. Create the Applications

In this exercise you will create the applications that help you understand the
different concepts. The applications will do the same in both programming
languages, greet people. Both applications are REST APIs. The applications are
not that advanced as this is not the focus of this track. You are allowed to go
for something more advanced if you find the time. It is recommended that you use
the same technologies so that you can apply the knowledge out of the different
tasks on your custom application.

### pygreeter

#### Cloning the Repository

1. Open [GitHub](https://github.com/) and login with your existing account
2. Search for the "pygreeter" on the left side and click on it
3. Copy the URL in the blue "Quick setup" box
4. Execute the following command but replace URL with the URL that you just
   copied.

   ```shell
   git clone URL
   ```

Optional: The same thing could have been done with the following GitHub CLI
command (replace USER with your GitHub username).

```shell
gh repo clone USER/pygreeter
```

#### Initializing the Project

To continue you have to create a new virtual environment.

1. Switch into the "pygreeter" directory

   ```shell
   cd pygreeter
   ```

2. Create the virtual environment

   ```shell
   python -m venv .venv
   ```

3. Active the virtual environment

   ```shell
   source .venv/bin/activate
   ```

This will create a virtual environment folder `.venv` within the application
directory and enable it within your current terminal session. This virtual
environment will make sure that the dependencies that you install are scoped to
the application and do not interfere with different applications. If you open
the folder in a new terminal session you will always have to repeat step three.

#### Create Entry Point

Next you have to create the entry point of the application or in other words the
place where the code execution will start from.

1. Create a new file named `main.py`
2. Enter the following code

   ```python
   if __name__ == "__main__":
       print("pygreeter")
   ```

3. Execute the entry point

   ```shell
   python main.py
   ```

After completing the final step you should see "pygreeter" in your console.

#### Install Dependencies

There are frameworks that help you create REST APIs. These have to be installed
first and can then be imported and used.

1. Install the `fastapi` package

   ```shell
   pip install "fastapi[all]"
   ```

2. Store the versions of the dependencies

   ```shell
   pip freeze > requirements.txt
   ```

#### Create Greeting Logic

The core logic of the application is greeting. You should be able to greet
someone with their name. If no name is provided you should fall back to a
generic way of greeting.

1. Create a new file named `greeter.py`
2. Create the core logic

   ```python
   def greet(name: str) -> str:
       if len(name) == 0:
           return f"Hello World!"
       return f"Hello {name}!"
   ```

#### Create REST API

To provide your service over an REST API you have to create a server with a
handler that passes the input to the core logic and then returns it to the user.
This is done with the help of the previously installed framework.

1. Replace the content of `main.py` with the following code

   ```python
   from fastapi import FastAPI
   from fastapi.responses import PlainTextResponse
   import uvicorn

   from greeter import greet

   app = FastAPI()


   @app.get("/", response_class=PlainTextResponse)
   def get_greeting(name: str = "") -> str:
       output = greet(name)
       return output


   if __name__ == "__main__":
       uvicorn.run(app, host="0.0.0.0", port=8080)
   ```

This code initially defines the `app` that is specific to `fastapi`. Then it
defines a function that is called when a `GET` call is made to the path `/`. The
`response_class` makes sure that the response will be displayed as plain text.
Within the `get_greeting` function the input from the query string is then
passed to the greeting logic and returned as response. As entry point you tell
`uvicorn` to start the server for our application on the port 8080 and to listen
on any address.

### gogreeter

#### Cloning the Repository

1. Open [GitHub](https://github.com/) and login with your existing account
2. Search for the "gogreeter" on the left side and click on it
3. Copy the URL in the blue "Quick setup" box
4. Execute the following command but replace URL with the URL that you just
   copied.

```shell
git clone URL
```

Optional: The same thing could have been done with the following GitHub CLI
command (replace USER with your GitHub username).

```shell
gh repo clone USER/gogreeter
```

#### Initializing the Project

To continue you have to create a new Go module.

1. Switch into the "gogreeter" directory

   ```shell
   cd gogreeter
   ```

2. Set up a new module in the same directory (replace USER with your GitHub
   username)

   ```shell
   go mod init github.com/USER/gogreeter
   ```

This will create a file named `go.mod` in the application directory
containing the required information for Go to function.

#### Create Entry Point

Next you have to create the entry point of the application or in other words the
place where the code execution will start from.

1. Create a new file named `main.go`
2. Enter the following code

   ```go
   package main

   import "fmt"

   func main() {
       fmt.Println("gogreeter")
   }
   ```

3. Execute the entry point

   ```shell
   go run .
   ```

After completing the final step you should see "gogreeter" in your console.

#### Install Dependencies

There are frameworks that help you create REST APIs. These have to be installed
first and can then be imported and used.

1. Install the `fiber` package

   ```shell
   go get github.com/gofiber/fiber/v2
   ```

#### Create Greeting Logic

The core logic of the application is greeting. You should be able to greet
someone with their name. If no name is provided you should fall back to a
generic way of greeting.

1. Create a new folder named `greeter`
2. Create a new file named `greeter.go` in the `greeter` folder
3. Create the core logic

   ```go
   package greeter

   import "fmt"

   func Greet(name string) string {
       if len(name) == 0 {
           return "Hello World!"
       }
       return fmt.Sprintf("Hello %s!", name)
   }
   ```

#### Create REST API

To provide your service over an REST API you have to create a server with a
handler that passes the input to the core logic and then returns it to the user.
This is done with the help of the previously installed framework.

1. Replace the content of `main.go` with the following code (replace USER with
   your GitHub username)

   ```go
   package main

   import (
       "net/http"

       "github.com/gofiber/fiber/v2"
       "github.com/USER/gogreeter/greeter"
   )

   func main() {
       app := fiber.New()

       app.Get("/", getGreeting)

       const ADDRESS = ":8080"
       app.Listen(ADDRESS)
   }

   func getGreeting(c *fiber.Ctx) error {
       input := c.Query("name")
       output := greeter.Greet(input)
       return c.Status(http.StatusOK).SendString(output)
   }
   ```

This code initially defines the `app` that is specific to `fiber`. Then it
registers a function that is called when a `GET` call is made to the path `/`.
Finally, the server for our application is starting to listen on every address
on the port 8080. Within the `getGreeting` function it gets the input from the
query string, it is then passed to our greeting logic and then returned as a
string response.

## 5. Testing the Applications

To make sure the greeting logic is working as expected you will have to test it
with the help of the built-in way of doing tests. This will be done with
so-called table tests. Table tests are testing the same piece of code with many
different inputs defined in a "table". This table is mostly done with the help
of built-in types like objects and arrays.

### pygreeter

#### Create Test Cases

1. Create a file named `test_greeter.py`
2. Create a test with multiple cases for the `greet` function

   ```python
   import unittest

   from greeter import greet


   class TestGreeter(unittest.TestCase):
       def test_greet(self):
           cases = [
               {"name": "zhews", "expected_output": "Hello zhews!"},
               {"name": "pygreeter", "expected_output": "Hello pygreeter!"},
               {"name": "", "expected_output": "Hello World!"},
               {"name": " ", "expected_output": "Hello World!"},
           ]
           for case in cases:
               with self.subTest(name=case.get("name")):
                   input = case.get("name")
                   expected_output = case.get("expected_output")
                   output = greet(input)
                   self.assertEqual(output, expected_output)
   ```

This creates tests for the `greet` function of the `greeter` module with the
help of the built-in `unittest` module. At first, it tests with two different
names, then with an empty string and in the end with a white space. Do you see
anything that could go wrong?

#### Run Test Cases

1. Run the tests with the `unittest` module

   ```shell
   python -m unittest
   ```

In the output you should see the last test case failing. Think about the logic
you added, why is it not returning "Hello World!"? In the greeting logic you
check for an empty but not a blank string.

#### Fix Code

1. Change the greet function to clean the name before checking for its length

   ```python
   def greet(name: str) -> str:
       cleaned_name = name.strip()
       if len(cleaned_name) == 0:
           return "Hello World!"
       return f"Hello {name}!"
   ```

The `strip` method removes any leading and trailing white spaces from the
string. So in case the string would have only been filled with white spaces it
would then be an empty string and our length check takes affect.

#### Rerun Tests

1. Run the tests with the `unittest` module

   ```shell
   python -m unittest
   ```

All tests should now be passing.

### gogreeter

#### Create Test Cases

1. Switch into the `greeter` directory
2. Create a file named `greeter_test.go`
3. Create a test with multiple cases for the `greet` function

   ```go
   package greeter

   import (
       "fmt"
       "testing"
   )

   func TestGreet(t *testing.T) {
       testCases := []struct {
           name           string
           expectedOutput string
       }{
           {
               name:           "zhews",
               expectedOutput: "Hello zhews!",
           },
           {
               name:           "gogreeter",
               expectedOutput: "Hello gogreeter!",
           },
           {
               name:           "",
               expectedOutput: "Hello World!",
           },
           {
               name:           " ",
               expectedOutput: "Hello World!",
           },
       }
       for _, testCase := range testCases {
           t.Run(fmt.Sprintf("Name: %s", testCase.name), func(tc *testing.T) {
               output := Greet(testCase.name)
               if testCase.expectedOutput != output {
                   tc.Fatalf("expected: %s, actual: %s", testCase.expectedOutput, output)
               }
           })
       }
   }
   ```

This creates tests for the `Greet` function of the `greeter` module with the
help of the built-in `testing` module. At first, it tests with two different
names, then with an empty string and in the end with a white space. Do you see
anything that could go wrong?

#### Run Test Cases

1. Run the tests with the `test` sub command

   ```shell
   go test ./...
   ```

In the output you should see the last test case failing. Think about the logic
you added, why is it not returning "Hello World!"? In the greeting logic you
check for an empty but not a blank string.

#### Fix Code

1. Change the greet function to clean the name before checking for its length

   ```go
   package greeter

   import (
       "fmt"
       "strings"
   )

   func Greet(name string) string {
       cleanedName := strings.TrimSpace(name)
       if len(cleanedName) == 0 {
           return "Hello World!"
       }
       return fmt.Sprintf("Hello %s!", name)
   }
   ```

The `TrimSpace` method removes any leading and trailing white spaces from the
string. So in case the string would have only been filled with white spaces it
would then be an empty string and our length check takes affect.

#### Rerun Tests

1. Run the tests with the `test` sub command

   ```shell
   go test ./...
   ```

All tests should now be passing.

## 6. Add Continuous Integration

To create an instant feedback loop you will add continuous integration to both
projects. In one project you will use GitHub Actions in the other one you will
use Jenkins. In both projects you will first clone the repository then check if
the code has been correctly formatted after that lint the code, then run all the
unit tests and in the end build a container image. The introduction to
containers will follow for now think about container images as software that
contains all the dependencies required for the application to run.

### pygreeter

For pygreeter you are going to use GitHub Actions. You want the workflow to
run on every push independent of the branch it is currently on.

#### Create the Containerfile

1. Create a file named `Containerfile` in the root of the project
2. Add the following content to the file

   ```Dockerfile
   FROM python:3.12
   WORKDIR /code
   COPY requirements.txt /code/requirements.txt
   RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
   COPY *.py /code/
   CMD ["python", "main.py"]
   ```

This `Containerfile` is in other projects also known as `Dockerfile`. It
contains the instructions on how the application should be built and then run.
In this case it fetches another container image as starting point. From there it
tells Podman to execute all the commands in the `/code` directory. Then it copies
the dependencies you have defined into the `/code` and installs them with `pip`.
After that it copies your code into the `/code` directory. Finally, it tells
Podman that the entry point of the container is `uvicorn`.

#### Build and Test the Container

1. Build the container

   ```bash
   podman build -t pygreeter .
   ```

2. Test out the container

   ```bash
   podman run -p 8080:8080 pygreeter:latest
   ```

3. Open the application in your browser on http://localhost:8080
4. Make sure it greets with provided names by passing query parameters to the
   URL http://localhost:8080?name=NAME (replace NAME with your name).
5. Stop the container by pressing CTRL+C

With the first command you told Podman to execute the steps you have defined in
the `Containerfile` and store it under the tag `pygreeter` as you only added the
name there will by default be the suffix `:latest`. With the container image now
being available you tell Podman to run the image with the second command. In the
same command you tell Podman that it should forward traffic going to port 8080
on your device to port 8080 within the container. Because of that you are then
able to access the website in your browser. As the container is running as an
active process in the current terminal session you will have to stop it by
clicking CTRL+C.

#### Add the Workflow

1. Create the `.github/workflows` folders in the root of your project

   ```bash
   mkdir -p .github/workflows
   ```

2. Create a file named `ci-cd.yaml` in the folder you have just created

   ```yaml
   on: [push]

   jobs:
     verify:
       runs-on: ubuntu-latest
       steps:
         - uses: "actions/checkout@v4"
         - uses: "actions/setup-python@v4"
           with:
             python-version: "3.12"
             cache: "pip"
         - run: "python -m pip install --upgrade pip"
         - run: "pip install -r requirements.txt"
         - run: "pip install black pylint"
         - run: "black --check ."
         - run: "pylint *.py --disable=C"
         - run: "python -m unittest"

     build:
       runs-on: ubuntu-latest
       steps:
         - uses: "actions/checkout@v4"
         - uses: "redhat-actions/buildah-build@v2"
           with:
             image: "pygreeter"
             tags: "latest ${{ github.sha }}"
             containerfiles: "./Containerfile"
   ```

This adds a workflow with two jobs for your pygreeter repository. The first job
does the verify part. It first clones the repository. Then install python with
version 3.12 and tells GitHub to cache the dependencies of `pip`. After that it
upgrades `pip`. Then it installs the dependencies of your application and the
tools used to verify. Finally, it does the verification. `black` is used to
check the formatting of the application. `pylint` is used to lint the
application code disabling some conventions that are not useful for your
project. The built-in `unittest` module is then used to execute the tests.

#### Check the Output of the Workflow

1. Open [GitHub](https://github.com/) and login with your existing account
2. Search for the "pygreeter" on the left side and click on it
3. Click on `Actions`
4. Click on the latest workflow below `All workflows`
5. Checkout the output of the `verify` job
6. Checkout the output of the `build` job

As you can see the `verify` job failed and the `build` job passed. Why did the
`verify` job fail? `pylint` detected that we are naming a variable `input` this
name overlaps with the built-in `input` function. So in case someone wants to
use the `input` method within the same scope it would not work as expected.

#### Fix the Code

1. Open the `test_greeter.py` file
2. Change the variable on line 16 from `input` to `name`
3. Again check the output of the work

### gogreeter

For gogreeter you are going to use Jenkins. You want a pipeline to
run on every push independent of the branch it is currently on.

#### Create the Containerfile

1. Create a file named `Containerfile` in the root of the project
2. Add the following content to the file

   ```Dockerfile
   FROM golang:1.21 AS build
   WORKDIR /code
   COPY go.mod go.sum /code/
   RUN go mod download && go mod verify
   COPY main.go /code/
   COPY greeter /code/greeter
   RUN CGO_ENABLED=0 go build -v -o /code/bin/gogreeter .

   FROM gcr.io/distroless/static-debian12:nonroot AS run
   WORKDIR /run
   COPY --from=build /code/bin/gogreeter /run/gogreeter
   CMD ["/run/gogreeter"]
   ```

This `Containerfile` is in other projects also known as `Dockerfile`. It
contains the instructions on how the application should be built and then run.
In this case it fetches another container image as starting point. From there it
tells Podman to execute all the commands in the `/code` directory. Then it copies
the modules you have defined into the `/code`, installs and verifies them.
After that it copies your code into the `/code` directory. Then it creates the
binary of the application and fetches a new container images as starting point.
From this starting point it defines the new directory to execute commands in is
`/run` then copies the new binary into the `/run` directory. Finally, it tells
Podman that the entry point of the container is the built binary.

#### Build and Test the Container

1. Build the container

   ```bash
   podman build -t gogreeter .
   ```

2. Test out the container

   ```bash
   podman run -p 8080:8080 gogreeter:latest
   ```

3. Open the application in your browser on http://localhost:8080
4. Make sure it greets with provided names by passing query parameters to the
   URL http://localhost:8080?name=NAME (replace NAME with your name).
5. Stop the container by pressing CTRL+C

With the first command you told Podman to execute the steps you have defined in
the `Containerfile` and store it under the tag `gogreeter` as you only added the
name there will by default be the suffix `:latest`. With the container image now
being available you tell Podman to run the image with the second command. In the
same command you tell Podman that it should forward traffic going to port 8080
on your device to port 8080 within the container. Because of that you are then
able to access the website in your browser. As the container is running as an
active process in the current terminal session you will have to stop it by
clicking CTRL+C.

#### Preparing Jenkins

As we covered in the presentation Jenkins is a solution that has to be hosted on
premise. Because of that you have to deploy it yourself. To do that you will use
`podman-compose`. A bigger introduction to containers will follow. For now, you
can think of `podman-compose` as a way to start and connect multiple containers
together.

1. Create a folder named `infra`
2. Create a file named `Containerfile` in the newly created folder
3. Add the following content to the file

   ```Dockerfile
   FROM jenkins/jenkins:2.426.1-jdk17
   USER root
   RUN apt-get update && apt-get install -y lsb-release
   RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
   https://download.docker.com/linux/debian/gpg
   RUN echo "deb [arch=$(dpkg --print-architecture) \
   signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
   https://download.docker.com/linux/debian \
   $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
   RUN apt-get update && apt-get install -y docker-ce-cli golang-go
   USER jenkins
   RUN jenkins-plugin-cli --plugins "docker-workflow"
   ```

4. Create a file named `compose.yaml` in the newly created folder
5. Add the following content

   ```yaml
   version: "3"
   services:
     docker:
       image: "docker:dind"
       hostname: "docker"
       environment:
         - "DOCKER_TLS_CERTDIR=/certs"
       ports:
         - "2376:2376"
       privileged: true
       volumes:
         - "jenkins-docker-certs:/certs/client"
         - "jenkins-data:/var/jenkins_home"
       restart: "always"
       dns:
         - "9.9.9.9"
         - "1.1.1.1"
     jenkins:
       build: "."
       hostname: "jenkins"
       ports:
         - "8080:8080"
         - "50000:50000"
       environment:
         - "DOCKER_HOST=tcp://docker:2376"
         - "DOCKER_CERT_PATH=/certs/client"
         - "DOCKER_TLS_VERIFY=1"
       volumes:
         - "jenkins-docker-certs:/certs/client:ro"
         - "jenkins-data:/var/jenkins_home"
       dns:
         - "9.9.9.9"
         - "1.1.1.1"
       depends_on:
         - "docker"
   volumes:
     jenkins-docker-certs: {}
     jenkins-data: {}
   ```

6. Start the infrastructure

   ```bash
   podman compose up
   ```

7. Open Jenkins in your browser on http://localhost:8080
8. Check the logs of command 6 and copy the admin password
9. Enter the admin password in the UI
10. Install the suggested plugins
11. Create the admin user
12. Leave the instance configuration as it is
13. Click start using Jenkins

By executing these commands you have successfully installed a local instance of
Jenkins. Be aware that this is not a production ready setup and is only for
testing purposes. The first `Containerfile` takes the Jenkins image as a
starting point and makes the Docker CLI available. Command wise Docker is the
same as Podman, and it depends on personal preference on what to use. In
companies, you will require a License for Docker whereas Podman can be used for
free. After that you created a `compose.yaml` file that defines which containers
with what configuration should be started. You reference the `Containerfile` on
one of the services and add configuration on both. They also share some volumes
so that Jenkins is able to access Docker securely. We will cover the
`compose.yaml` file in more details in a later lessen. With the 6 command you
then tell Podman to start the services accordingly. In the end you go through
the initial setup of Jenkins.

#### Create the Pipeline

1. Create a file named `Jenkinsfile` in the root of your directory
2. Add the following content

   ```Jenkinsfile
   pipeline {
        agent any
        stages {
            stage("Checkout") {
                steps {
                    checkout scm
                }
            }
            stage("Install Verify Tools") {
                steps {
                    sh "curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.55.2"
                }
            }
            stage("Verify") {
                steps {
                    sh "./bin/golangci-lint run"
                    sh "go test ./..."
                }
            }
            stage("Go Build") {
                steps {
                    sh "go build -o ./bin/gogreeter ."
                }
            }
            stage("Container Build") {
                steps {
                    sh "docker build -t gogreeter -f Containerfile ."
                }
            }
        }
   }
   ```

This `Jenkinsfile` will at first clone the repository you will define in
Jenkins. Then it will install `golangci-lint` in a folder named `bin`. In the
verify stage it will then validate the code with `golangci-lint` and run the
unit tests. After that it will build the code into an executable and in the end
create a container image.

#### Add your GitHub Credentials to Jenkins

Optional: this is only required if your repository is not public.

1. Open Jenkins in your browser on http://localhost:8080
2. Login with your previously created user
3. Click "Manage Jenkins" on the left side
4. Click "Credentials" under "Security"
5. Click on "System"
6. Click on "Global credentials"
7. Click "Add Credentials"
8. Leave everything as it is and fill out "Username" and "Password"
9. "ID" should be the value "github-credentials"

This creates a secret that is accessible within your Pipeline. Usually it is not
a good practice to store the credentials globally but as you use the instance
just for yourself this will not be a problem.

#### Add the Pipeline to Jenkins

1. Open Jenkins in your browser on http://localhost:8080
2. Login with your previously created user
3. Click on "New Item"
4. Enter "gogreeter" as name
5. Choose "Multibranch Pipeline"
6. Enter "gogreeter" as display name
7. Click on "Add source" below "Branch Sources"
8. Select "Git"
9. Enter "https://github.com/USER/gogreeter.git" into project repository
   (replace USER with your GitHub username)
10. If your repository is private, choose the previously created
    "github-credentials" under "Credentials"
11. Click on "Save"

This creates a new multibranch pipeline under the name "gogreeter" (a pipeline
for each branch of your repository) that gets the Jenkins file from GitHub and
starts the build for each branch.

#### Check the Output of the Pipeline

1. Open Jenkins in your browser on http://localhost:8080
2. Login with your previously created user
3. Click on "gogreeter"
4. Click on "main"
5. Click on "#1"
6. Click on "Console Output"

As you can see the verify stage is failing. Why did the verify stage fail?
`golanci-lint` detected that a possible error that could be produced is not
handled. In case this error would actually occur we would never know what
happened.

#### Fix the Code

1. Open the `main.go` file
2. Above line 4 add `"log"`
3. Replace line 17 with the following

   ```go
   if err := app.Listen(ADDRESS); err != nil {
   	log.Fatal("failed to listen on address", err)
   }
   ```

4. Start another build and recheck the output of the pipeline

## 7. Add Continuous Delivery

To make your artifacts available to other people or the solution you use for
hosting the application you will add continuous delivery. In one project you
will use GitHub Container Registry in the other one you will use Nexus.

### pygreeter

For pygreeter you are going to use GHCR. You want GitHub Actions to only push
the image if it is currently executing on main.

#### Add Write Access to the Workflow

1. Open [GitHub](https://github.com/) and login with your existing account
2. Search for the "pygreeter" on the left side and click on it
3. Click on "Settings"
4. Click on "Actions"
5. Click on "General"
6. Click on "Read and write permissions" under "Workflow permissions"

With these permissions the workflows are able to publish artifacts to the GHCR
of the current repository.

#### Extend the Workflow

1. Open the `.github/workflows/ci-cd.yaml` file
2. Rename the `build` job to `build-and-push`
3. Add the `id` field to the last step with the value `build`
4. Add the following steps to it

   ```yaml
   - uses: "redhat-actions/push-to-registry@v2"
     if: "github.ref == 'refs/heads/main'"
     env:
       IMAGE_REGISTRY: "ghcr.io/${{ github.repository_owner }}"
     with:
       image: "${{ steps.build.outputs.image }}"
       tags: "${{ steps.build.outputs.tags }}"
       registry: "${{ env.IMAGE_REGISTRY }}"
       username: "$"
       password: "${{ secrets.GITHUB_TOKEN }}"
   ```

This step will use a publicly available action to push the artifact to GHCR. It
does that with the outputs of the previous step, the registry environmental
variable, user and token. The token is a built-in functionality from GitHub
Actions.

#### Login to the Registry

Optional: this is only required if your repository is not public.

1. Follow the instructions on how to create an access token
   [here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic).
   As scope use the values `read:packages`, `write:packages` and
   `delete:packages`.
2. Login to the registry (use your GitHub username as user and the previously
   created access token as password)

   ```bash
   podman login ghcr.io
   ```

#### Pull and Test the Image

1. Pull the image (replace USER with your GitHub username)

   ```bash
   podman pull ghcr.io/USER/pygreeter:latest
   ```

2. Run the image (replace USER with your GitHub username)

   ```bash
   podman run -p 8080:8080 ghcr.io/USER/pygreeter:latest
   ```

You have now successfully published the artifact

### gogreeter

For gogreeter you are going to use Nexus. You want Jenkins to only push
the image if it is currently executing on main.

#### Extend Infrastructure

1. Open the `infra/compose.yaml` file
2. Add the following command to the docker service

   ```yaml
   command:
     - "--insecure-registry=nexus:8082"
   ```

3. Add the following service

   ```yaml
   nexus:
     image: "sonatype/nexus3"
     hostname: "nexus"
     ports:
       - "8081:8081"
       - "8082:8082"
     volumes:
       - "nexus-data:/nexus-data"
     dns:
       - "9.9.9.9"
       - "1.1.1.1"
   ```

4. Add the following volume

   ```yaml
   nexus-data: {}
   ```

5. Start the infrastructure

   ```bash
   podman-compose up
   ```

6. Open Nexus in your browser on http://localhost:8081
7. Get the `admin` password

   ```bash
   podman exec infra_nexus_1 cat /nexus-data/admin.password
   ```

8. Click "Sign In"
9. Use `admin` as username and the password you got from the previous command
10. Click "Next"
11. Choose your new password and "Next"
12. Click "Disable anonymous access" and "Next"
13. Click "Finish"

By adding the service and volume and then following the instructions on setting
up you have successfully installed Nexus.

#### Create Repository

1. Open Nexus in your browser on http://localhost:8081
2. Login as `admin` with your previously changed password
3. Click the settings wheel on the top
4. Click "Repositories"
5. Click "Create repository"
6. Click "docker (hosted)"
7. Enter "gogreeter" as name
8. Enable the tick under "HTTP" and choose the port `8082`
9. Click "Create repository"

You have now successfully created a repository in Nexus that is able to store
container images. It will be accessible on port `8082` and because it is a test
environment not use any encryption, but you will see that later.

#### Add Credentials to Jenkins

1. Open Jenkins in your browser on http://localhost:8080
2. Login with your previously created user
3. Click "Manage Jenkins" on the left side
4. Click "Credentials" under "Security"
5. Click on "System"
6. Click on "Global credentials"
7. Click "Add Credentials"
8. Leave everything as it is and fill out "Username" as `admin` and "Password"
   with the one you have previously chosen
9. "ID" should be the value "nexus-credentials"

This creates a secret that is accessible within your Pipeline. Usually it is not
a good practice to store the credentials globally but as you use the instance
just for yourself this will not be a problem. It is also not a good practice to
store admin credentials. Always use credentials that go with the principle of
the least privilege meaning it can only do what it has to do. As it is a testing
environment in this case we will leave it.

#### Extend the Pipeline

1. Open the `Jenkinsfile` file
2. Replace line 27 with the following

   ```Jenkinsfile
   sh 'docker build -t nexus:8082/gogreeter:latest -t nexus:8082/gogreeter:$GIT_COMMIT -f Containerfile .'
   ```

3. Add the following stage

   ```Jenkinsfile
   stage("Container Push") {
       when {
           branch 'main'
       }
       environment {
           NEXUS_CREDENTIALS = credentials("nexus-credentials")
       }
       steps {
           sh 'echo $NEXUS_CREDENTIALS_PSW | docker login nexus:8082 -u $NEXUS_CREDENTIALS_USR --password-stdin'
           sh "docker push nexus:8082/gogreeter:latest"
           sh 'docker push nexus:8082/gogreeter:$GIT_COMMIT'
       }
   }
   ```

#### Login to the Registry

1. Login to the registry (use `admin` as user and the previously
   changed password)

   ```bash
   podman login localhost:8082 --tls-verify=false
   ```

The `tls-verify=false` flag is required as in our test environment the endpoint
is not secured by TLS.

#### Pull and Test the Image

1. Pull the image

   ```bash
   podman pull localhost:8082/gogreeter:latest --tls-verify=false
   ```

2. Run the image

   ```bash
   podman run -p 8080:8080 localhost:8082/gogreeter:latest --tls-verify=false
   ```

You have now successfully published the artifact.

## 8. Set Up Virtual Machines

To get some knowledge on how to do different Sysadmin tasks you will setup two
different VMs and then install your application within them. In both VMs you
will use Linux but different distributions so that you get to see some common
differences. You will be using Oracle VirtualBox a type II hypervisor. The focus
of this is exercises is mainly to get more comfortable with some common tasks in
the command line and see the differences between two Linux distributions.

### pygreeter

For pygreeter you will be using Ubuntu as the Linux distribution.

#### Installing the ISO

1. Install the Ubuntu Server 22.04 LTS ISO from
   (https://ubuntu.com/download/server)

An ISO file is an exact copy of an entire optical disk like CD or DVD. This
file type commonly used to store an installer for operating systems on and can
then be written to a USB stick or used within a hypervisor to do the
installation of the operating system.

#### Preparing the Virtual Machine

1. Open Virtual Box
2. Click "New"
3. Choose "Ubuntu for pygreeter" as the name
4. Choose a folder where you want to store files related to the VM
5. Choose the previously downloaded ISO file as ISO image
6. Choose "Linux" as type
7. Choose "Ubuntu" as version
8. Choose "Skip Unattended Installation"
9. Click "Next"
10. Give your VM around 2048 of memory (make sure it stays in the green area)
11. Give your VM around 2 CPUs
12. Click "Enable EFI"
13. Click "Next"
14. Choose "Create a Virtual Hard Disk Now"
15. Choose 20GB
16. Click "Next"
17. Click "Finish"

This will tell Virtual Box that you are going to create a Linux Virtual Machine
with Ubuntu as distribution that uses 2 GB of memory, around 2 CPUs, 20 GB of
storage and uses UEFI to boot the operating system. Virtual Box will then take
care of the preparation.

#### Installing the Operating System

1. Click "Start"
2. Choose "Try or Install Ubuntu Server"
3. Choose "English" as language
4. Choose "Update to new installer" and hit enter
5. Choose "Identify keyboard" and hit enter
6. Click "Done"
7. Choose "Ubuntu Server (minimized)"
8. Click "Done"
9. Let it detect the interface
10. Click "Done"
11. Click "Done"
12. Make sure the mirror passed the location test
13. Click "Done"
14. Click "Done"
15. Click "Done"
16. Click "Continue"
17. Fill out your user details (name the server "ubuntu")
18. Click "Done"
19. Click "Done"
20. Click "Done"
21. Click "Done"
22. Wait for the installation and updates to finish
23. Click "Reboot now"

You have now successfully installed a minimal version of Ubuntu server. It
contains your user, your language, the right keyboard configuration and basic
network access.

#### Basic Configuration

1. Login with the newly created user

2. Install the required tools

   ```bash
   sudo apt-get install software-properties-common
   sudo add-apt-repository ppa:deadsnakes/ppa
   sudo apt-get update
   sudo apt-get install git vim python3.12 python3.12-dev python3.12-venv
   ```

3. Add a user for pygreeter (do not enter any more information, then hit enter)

   ```bash
   sudo adduser pygreeter
   ```

4. Switch to the pygreeter user

   ```bash
   su pygreeter
   ```

At first, you added a new place your package manager is able to use to search for
packages. In this case to look for newer versions of python. With the new
repository you tell apt to update its indexes and then install git, a basic text
editor and everything required for python. After that you created a user to run
the application with the name `pygreeter`. In the end you switch into the user
session of the newly created user.

#### Install the Application

1. Create a folder named `services` in the home directory of `pygreeter`

   ```bash
   cd
   mkdir services
   ```

2. Switch into the `services` directory

   ```bash
   cd services
   ```

3. Clone the repository of `pygreeter` (replace USER with your GitHub username)

   ```bash
   git clone https://github.com/USER/pygreeter.git
   ```

4. Switch into the `pygreeter` directory

   ```bash
   cd pygreeter
   ```

5. Create a virtual environment

   ```bash
   python3.12 -m venv .venv
   ```

6. Activate the virtual environment

   ```bash
   source .venv/bin/activate
   ```

7. Install the requirements

   ```bash
   pip3.12 install -r requirements.txt
   ```

The freshly installed server now contains everything it needs to run pygreeter.

#### Starting the Application as a Service

1. Create a file named `pygreeter.service`

2. Add the following content

   ```
   [Unit]
   Description=Service of pygreeter
   After=multi-user.target

   [Service]
   Type=simple
   ExecStart=/home/pygreeter/services/pygreeter/.venv/bin/python /home/pygreeter/services/pygreeter/main.py
   User=pygreeter

   [Install]
   WantedBy=multi-user.target
   ```

3. Exit the user session of pygreeter

   ```bash
   exit
   ```

4. Copy the `pygreeter.service` file to `/usr/lib/systemd/system`

   ```bash
   sudo cp /home/pygreeter/services/pygreeter/pygreeter.service /usr/lib/systemd/system
   ```

5. Reload the systemd daemon

   ```bash
   sudo systemctl daemon-reload
   ```

6. Enable the pygreeter service

   ```bash
   sudo systemctl enable --now pygreeter.service
   ```

This will start your application as a service. This means that the application
will be running after reboots as well. The `pygreeter.service` file you defined
tells your service configuration program how and when to run the service as well
as which user to run it as.

#### Test the Application

1. Make an HTTP request to the application

   ```bash
   curl localhost:8080
   ```

#### Additional Exercise

Try to figure out how you could access the now started service from within your
host operating system.

### gogreeter

For gogreeter you will be using Rocky as the Linux distribution.

#### Installing the ISO

1. Install the Rocky 9 Linux ISO from (https://rockylinux.org/download/)

An ISO file is an exact copy of an entire optical disk like CD or DVD. This
file type commonly used to store an installer for operating systems on and can
then be written to a USB stick or used within a hypervisor to do the
installation of the operating system.

#### Preparing the Virtual Machine

1. Open Virtual Box
2. Click "New"
3. Choose "Rocky for gogreeter" as the name
4. Choose a folder where you want to store files related to the VM
5. Choose the previously downloaded ISO file as ISO image
6. Choose "Linux" as type
7. Choose "Redhat" as version
8. Choose "Skip Unattended Installation"
9. Click "Next"
10. Give your VM around 2048 of memory (make sure it stays in the green area)
11. Give your VM around 2 CPUs
12. Click "Enable EFI"
13. Click "Next"
14. Choose "Create a Virtual Hard Disk Now"
15. Choose 20GB
16. Click "Next"
17. Click "Finish"

This will tell Virtual Box that you are going to create a Linux Virtual Machine
with Rocky as distribution that uses 2 GB of memory, around 2 CPUs, 20 GB of
storage and uses UEFI to boot the operating system. Virtual Box will then take
care of the preparation.

#### Installing the Operating System

1. Choose "Install Rocky Linux 9.3"
2. Choose "English"
3. Click "Continue"
4. Make sure that everything that does not have a exclamation mark has the right
   value for your setup.
5. Click "Instalation Destination"
6. Click "Done"
7. Click "Root Password"
8. Select a password and confirm it
9. Click "Lock root account"
10. Click "Done"
11. Click "User Creation"
12. Fill out the missing values
13. Click "Make this user administrator"
14. Click "Done"
15. Click "Begin Installation"
16. Click "Reboot System"

You have now successfully installed a minimal version of Rocky 9. It contains
your user, your language, the right keyboard configuration and basic network
access.

#### Basic Configuration

1. Login with the newly created user

2. Install the required tools

   ```bash
   sudo dnf install git vim golang
   ```

3. Add a user for gogreeter

   ```bash
   sudo useradd gogreeter
   sudo passwd gogreeter
   ```

4. Switch to the pygreeter user

   ```bash
   su gogreeter
   ```

At first, you install git, a basic text editor and the go programming language.
After that you created a user to run the application with the name `gogreeter`
and changed its password. In the end you switch into the user session of the
newly created user.

#### Installing the Application

1. Create a folder named `services` in the home directory of `gogreeter`

   ```bash
   cd
   mkdir services
   ```

2. Switch into the `services` directory

   ```bash
   cd services
   ```

3. Clone the repository of `gogreeter` (replace USER with your GitHub username)

   ```bash
   git clone https://github.com/USER/gogreeter.git
   ```

4. Switch into the `gogreeter` directory

   ```bash
   cd gogreeter
   ```

5. Build the `gogreeter` executable

   ```bash
   go build -o ./bin/gogreeter .
   ```

The freshly installed server now contains everything it needs to run gogreeter.

#### Starting the Application as a Service

1. Move the newly created binary to `/usr/local/bin`

   ```bash
   sudo cp /home/gogreeter/services/gogreeter/bin/gogreeter /usr/local/bin
   ```

2. Create a file named `gogreeter.service`

3. Add the following content

   ```
   [Unit]
   Description=Service of gogreeter
   After=multi-user.target

   [Service]
   Type=simple
   ExecStart=/usr/local/bin/gogreeter
   User=gogreeter

   [Install]
   WantedBy=multi-user.target
   ```

4. Exit the user session of gogreeter

   ```bash
   exit
   ```

5. Copy the `gogreeter.service` file to `/usr/lib/systemd/system`

   ```bash
   sudo cp /home/gogreeter/services/gogreeter/gogreeter.service /usr/lib/systemd/system
   ```

6. Reload the systemd daemon

   ```bash
   sudo systemctl daemon-reload
   ```

7. Enable the gogreeter service

   ```bash
   sudo systemctl enable --now gogreeter.service
   ```

This will start your application as a service. This means that the application
will be running after reboots as well. The `gogreeter.service` file you defined
tells your service configuration program how and when to run the service as well
as which user to run it as. You had to move the executable to a `/usr/local/bin`
because Rocky Linux comes with a tool called SELinux (a security hardening tool)
that disallows running personal user binaries as services.

#### Test the Application

1. Make an HTTP request to the application

   ```bash
   curl localhost:8080
   ```

#### Additional Exercise

Try to figure out how you could access the now started service from within your
host operating system.

## 9. Extend the Containerfiles

Now what you know more about container and how they can be orchestrated you will
extend the two Containerfiles that you have already created with some
documenting instructions. This time you will actually know what is going on when
you execute the commands. Because you already have the infrastructure for CI/CD
you will just able to add the new instructions and can then push it from the
registry.

### pygreeter

#### Extend the Containerfile

1. Open the `Containerfile` file
2. Add the following instructions to the end of the file

```Dockerfile
EXPOSE 8080
```

Someone using you Containerfile will now know that they need to forward the port
8080 in case they want to access the image.

Additional exercise: write down what each of the instructions within the
Containerfile does and think about a way to improve the layers or if they are
already fine like that.

#### Fetch

1. Optional: login to the registry in case it is private

   ```bash
   podman login ghcr.io
   ```

2. Fetch the newly created image (replace USER with your GitHub username)

   ```bash
   podman pull ghcr.io/USER/pygreeter:latest
   ```

The new change to the container image should now be present on your local
system. To make sure inspect the container.

3. Inspect the container

   ```bash
   podman inspect ghcr.io/USER/pygreeter:latest
   ```

Checkout the last layer, it should have the EXPOSE instruction.

#### Play with the Container

1. Run the container in detached mode and forward to a free port (replace USER
   with your GitHub username)

   ```bash
   podman run -d -p 8085:8080 ghcr.io/USER/pygreeter
   ```

2. Perform an HTTP request within the container and store the response in a file

   ```bash
   podman exec <id-or-name-of-previous-command> 'curl http://localhost:8080 -o response.txt'
   ```

3. Copy the file onto your machine

   ```bash
   podman cp <id-or-name-of-previous-command>:/code/response.txt response.txt
   ```

4. Check out the response

   ```bash
   cat response.txt
   ```

5. Stop the container

   ```
   podman stop <id-or-name-of-previous-command>
   ```

### gogreeter

#### Extend the Containerfile

1. Open the `Containerfile` file
2. Add the following instructions to the end of the file

```Dockerfile
EXPOSE 8080
```

Someone using you Containerfile will now know that they need to forward the port
8080 in case they want to access the image.

Additional exercise: write down what each of the instructions within the
Containerfile does and think about a way to improve the layers or if they are
already fine like that.

#### Fetch

1. Login to the registry as it is private

   ```bash
   podman login localhost:8082
   ```

2. Fetch the newly created image

   ```bash
   podman pull localhost:8082/gogreeter:latest
   ```

The new change to the container image should now be present on your local
system. To make sure inspect the container.

3. Inspect the container

   ```bash
   podman inspect localhost:8082/gogreeter:latest
   ```

Checkout the last layer, it should have the EXPOSE instruction.

#### Play with the Container

1. Run the container in detached mode and forward to a free port (replace USER
   with your GitHub username)

   ```bash
   podman run -d -p 8085:8080 localhost:8082/gogreeter
   ```

2. Perform an HTTP request within the container and store the response in a file

   ```bash
   podman exec <id-or-name-of-previous-command> 'curl http://localhost:8080 -o response.txt'
   ```

3. Copy the file onto your machine

   ```bash
   podman cp <id-or-name-of-previous-command>:/code/response.txt response.txt
   ```

4. Check out the response

   ```bash
   cat response.txt
   ```

5. Stop the container

   ```
   podman stop <id-or-name-of-previous-command>
   ```

## 10. Deploy Applications with Kubernetes

In this exercise you are going to the deploy the existing containers of your
application within a local Kubernetes cluster. Be aware that I changed one of
the tools you need to install. Instead of `kind` we are going to use `k3s` as it
does not depend on either Podman or Docker. As soon as you have `k3s` installed
your `kubectl` should be configured accordingly.

1. Check if you can access the empty local cluster

   ```bash
   kubectl get all
   ```

You will create the `Deployment` resource for both of your applications. You
will then create a service to make the applications accessible from within the
cluster. You will then access the applications from a pod within the cluster and
scale the application up and down.

### pygreeter

#### Create a Deployment

1. Create a folder named `k8s`
2. Create a file named `deployment.yaml` within this folder
3. Add the following content (replace USER with your GitHub username)

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     labels:
       app: pygreeter
     name: pygreeter
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: pygreeter
     template:
       metadata:
         labels:
           app: pygreeter
       spec:
         containers:
           - image: ghcr.io/USER/pygreeter
             name: pygreeter
             ports:
               - containerPort: 8080
   ```

This file is defines what Kubernetes should create. In this example a
deployment. A deployment creates replica sets with your pod configuration
for you and provides some additional functionality for scaling and rollbacks
that you will learn later.

4. Optional: in case that your repository is private you will have to first add
   an image pull secret and add it to the definition (replace USER, TOKEN and
   EMAIL with your corresponding values. The TOKEN is the one you have already
   created for GitHub)

   ```bash
   kubectl create secret docker-registry ghcr-secret --docker-server=https://ghcr.io --docker-username=USER --docker-password=TOKEN --docker-email=EMAIL
   ```

   Add the image pull secret under `.spec.template.spec.imagePullSecrets`

   ```yaml
   imagePullSecrets:
     - name: ghcr-secret
   ```

5. Add the deployment to the cluster

   ```bash
   kubectl apply -f deployment.yaml
   ```

   Instead of defining your deployments in YAML you could also execute the
   following command (replace USER with your GitHub username).

   ```
   kubectl create deployment --image ghcr.io/USER/pygreeter --port 8080 pygreeter
   ```

   But in case you required an image pull secret that will not be possible from
   the command line.

6. Check if the application is running

   ```bash
   kubectl get deployment
   kubectl get replicaset
   kubectl get pod
   ```

7. Checkout the logs of the pod

   ```bash
   kubectl logs pods/<pod-id-from-previous-command>
   ```

8. Scale the deployment

   ```bash
   kubectl scale --replicas=3 deployment pygreeter
   ```

9. Check the new pods that are starting

   ```bash
   kubectl get pod
   ```

10. Change the image of the deployment to something that does not exist

    ```bash
    kubectl edit deployment pygreeter
    ```

11. Check that the new pod is not able to start

    ```bash
    kubectl get pod
    ```

12. Checkout all revisions of the deployment

    ```bash
    kubectl rollout history deployment pygreeter
    ```

13. Rollback to the previous revision

    ```bash
    kubectl rollout undo deployment pygreeter
    ```

You have now successful deployed pygreeter within Kubernetes and checked out
some common commands related to deployments. Let's check out how you can expose
the deployment within the cluster.

#### Create a Service

1. Create a file named `service.yaml`
2. Add the following content

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     labels:
       app: pygreeter
     name: pygreeter
   spec:
     ports:
       - port: 8080
         protocol: TCP
         targetPort: 8080
     selector:
       app: pygreeter
   ```

3. Add the service to the cluster

   ```bash
   kubectl apply -f service.yaml
   ```

   Instead of defining your services in YAML you could also execute the
   following command. In case you need more advanced service configuration this
   will not be possible.

   ```bash
   kubectl expose deployment/pygreeter
   ```

4. Access the application

   ```
   kubectl run --rm -it --image alpine -- sh
   wget 'http://pygreeter:8080' -O response.txt
   cat response.txt
   exit
   ```

   This start a container within the cluster and starts and interactive shell.
   Within this shell you can then use `wget` to make an HTTP call to the pygreeter
   service and write it to the file `response.txt`. In the end you can exit the
   container, and it will be removed from the cluster.

You have now successfully exposed your application within the cluster. You also
learned how to quickly spawn a container in a cluster to test some things.

### gogreeter

#### Import the Image

As k3s will not be able to access your local registry you will have to import
the container image of gogreeter manually.

1. Import the image

   ```bash
   podman save localhost:8082/gogreeter:latest | k3s ctr images import -
   ```

This will create an archive of the image and import it into the container
runtime of k3s.

#### Create a Deployment

1. Create a folder named `k8s`
2. Create a file named `deployment.yaml` within this folder
3. Add the following content

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     labels:
       app: gogreeter
     name: gogreeter
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: gogreeter
     template:
       metadata:
         labels:
           app: gogreeter
       spec:
         containers:
           - image: localhost:8082/gogreeter:latest
             imagePullPolicy: Never
             name: gogreeter
             ports:
               - containerPort: 8080
   ```

This file is defines what Kubernetes should create. In this example a
deployment. A deployment creates replica sets with your pod configuration
for you and provides some additional functionality for scaling and rollbacks
that you will learn later. This pod configuration also has a flag to never pull
the gogreeter container image from a registry as we have already imported it.

4. Add the deployment to the cluster

   ```bash
   kubectl apply -f deployment.yaml
   ```

   Instead of defining your deployments in YAML you could also execute the
   following command (replace USER with your GitHub username).

   ```
   kubectl create deployment --image localhost:8082/gogreeter:latest --port 8080 gogreeter
   ```

   But in case you required an image pull policy that will not be possible from
   the command line.

5. Check if the application is running

   ```bash
   kubectl get deployment
   kubectl get replicaset
   kubectl get pod
   ```

6. Checkout the logs of the pod

   ```bash
   kubectl logs pods/<pod-id-from-previous-command>
   ```

7. Scale the deployment

   ```bash
   kubectl scale --replicas=3 deployment gogreeter
   ```

8. Check the new pods that are starting

   ```bash
   kubectl get pod
   ```

9. Change the image of the deployment to something that does not exist

   ```bash
   kubectl edit deployment gogreeter
   ```

10. Check that the new pod is not able to start

    ```bash
    kubectl get pod
    ```

11. Checkout all revisions of the deployment

    ```bash
    kubectl rollout history deployment gogreeter
    ```

12. Rollback to the previous revision

    ```bash
    kubectl rollout undo deployment gogreeter
    ```

You have now successful deployed gogreeter within Kubernetes and checked out
some common commands related to deployments. Let's check out how you can expose
the deployment within the cluster.

#### Create a Service

1. Create a file named `service.yaml`
2. Add the following content

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     labels:
       app: gogreeter
     name: gogreeter
   spec:
     ports:
       - port: 8080
         protocol: TCP
         targetPort: 8080
     selector:
       app: gogreeter
   ```

3. Add the service to the cluster

   ```bash
   kubectl apply -f service.yaml
   ```

   Instead of defining your services in YAML you could also execute the
   following command. In case you need more advanced service configuration this
   will not be possible.

   ```bash
   kubectl expose deployment/gogreeter
   ```

4. Access the application

   ```
   kubectl run --rm -it --image alpine -- sh
   wget 'http://gogreeter:8080' -O response.txt
   cat response.txt
   exit
   ```

   This start a container within the cluster and starts and interactive shell.
   Within this shell you can then use `wget` to make an HTTP call to the pygreeter
   service and write it to the file `response.txt`. In the end you can exit the
   container, and it will be removed from the cluster.

You have now successfully exposed your application within the cluster. You also
learned how to quickly spawn a container in a cluster to test some things.

## 11. Migrate to AWS Lambda

One service AWS is known for is Lambda. Lambda is a compute service that lets
you define functions that are executed based on different events. One event
could be an HTTP request. Lambda is really cheap and only billed based on the
time the functions are executing, but there is a free tier that covers a lot of
function executions. These functions can be written in many different
programming languages in your case both Python and Go are supported. In this
exercise you will migrate your greet function in both py- and gogreeter to AWS
Lambda and make them execute through an HTTP request. For now, you will do this
via ClickOps or in other words within the management console of AWS. In the next
exercise you will work with another cloud provider provisioning and configuring
your infrastructure as code.

For you to do this exercise you will first have to create an AWS account. This
will require a credit card that you will have to add to the account. This
exercise will stay in the free tier as long as you follow it precisely and do
not create any other resources.

To create the account follow the instructions of AWS
[here](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-creating.html).

In this exercise we are going to perform the actions under the accounts root
user. In any other work environment this is HIGHLY not recommended.

### pygreeter

1. Open the AWS Console [here](https://console.aws.amazon.com)
2. Log in with your newly created user
3. Select "Europe (Frankfurt)" next to your account name
4. Search for Lambda in the upper search bar
5. In the left menu select "Functions"
6. Click "Create Function"
7. Select "Author from scratch"
8. As a function name choose "pygreeter"
9. As runtime choose "Python 3.11"
10. Click "Advanced settings"
11. Select "Enable function URL"
12. Select "None" under "Auth type"
13. Click "Create function"
14. Under the "Code" section change the content of the file `lambda_function.py`

    ```python
    import json


    def greet(name: str) -> str:
        cleaned_name = name.strip()
        if len(cleaned_name) == 0:
            return "Hello World!"
        return f"Hello {name}!"


    def lambda_handler(event, context) -> dict:
        query_params = event.get("queryStringParameters", {})
        name = query_params.get("name", "")
        output = greet(name)
        return {
            "statusCode": 200,
            "body": json.dumps(output),
        }
    ```

15. Click on "Deploy"
16. Copy the "Function URL" under the "Function Overview"
17. Access the function under the just copied URL

You have now deployed your first AWS Lambda function. The function will be
visible under "pygreeter" in the Lambda section of the AWS Console. You decided
to create the code for the function within the browser and to use python 3.11.
Code wise nothing related to your business logic changed. You just had to change
the way you get the input. In this case AWS Lambda provides the event that
caused the execution into the function. From there you are able to get the query
parameters and fallback to default values in case they are not there. With the
advanced settings section you made your function accessible over the internet to
anyone. This works because AWS in the back creates a role that allows everyone
to access it. Under the URL you copied you will then be able to use the
application the way you are used too locally.

### gogreeter

1. Open the AWS Console [here](https://console.aws.amazon.com)
2. Log in with your newly created user
3. Select "Europe (Frankfurt)" next to your account name
4. Search for Lambda in the upper search bar
5. In the left menu select "Functions"
6. Click "Create Function"
7. Select "Author from scratch"
8. As a function name choose "gogreeter"
9. As runtime choose "Go 1.x"
10. Click "Advanced settings"
11. Select "Enable function URL"
12. Select "None" under "Auth type"
13. Click "Create function"
14. Switch into your gogreeter folder
15. Create a new folder named `cmd` with the subfolders `gogreeter` and
    `gogreeter-lambda`
16. Move `main.go` into `cmd/gogreeter`
17. Change line 5 to the following content

    ```Dockerfile
    COPY cmd/gogreeter /code/cmd/gogreeter
    ```

18. Change line 7 to the following instruction

    ```Dockerfile
    RUN CGO_ENABLED=0 go build -v -o /code/bin/gogreeter ./cmd/gogreeter
    ```

19. Install new dependencies for lambda

    ```bash
    go get github.com/aws/aws-lambda-go/lambda
    go get github.com/aws/aws-lambda-go/events
    ```

20. Within `cmd/gogreeter-lambda` create a file named `main.go`
21. Add the following code to the newly created file (replace USER with your
    GitHub username)

    ```go
    package main

    import (
        "context"
        "encoding/json"
        "fmt"

        "github.com/aws/aws-lambda-go/events"
        "github.com/aws/aws-lambda-go/lambda"
        "github.com/USER/gogreeter/greeter"
    )

    func HandleRequest(ctx context.Context, event events.APIGatewayV2HTTPRequest) ([]byte, error) {
        name := event.QueryStringParameters["name"]
        greeting := greeter.Greet(name)
        output, err := json.Marshal(greeting)
        if err != nil {
            return nil, fmt.Errorf("could not marshal greeting %w", err)
        }
        return output, nil
    }

    func main() {
        lambda.Start(HandleRequest)
    }
    ```

22. Create the executable of the lambda handler

    ```bash
    GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build ./cmd/gogreeter-lambda -o main
    ```

23. Create a zip file containing the executable

    ```bash
    zip function.zip main
    ```

24. Under "Runtime settings" click "Edit"
25. Under "Handler" enter "main"
26. Click "Save"
27. Under "Code source" click "Upload from .zip file" and upload the newly
    created function
28. Copy the "Function URL" under the "Function Overview"
29. Access the function under the just copied URL

You have now deployed your second AWS Lambda function. The function will be
visible under "gogreeter" in the Lambda section of the AWS Console. With Go you
are not able to change the code within the browser. That is why you added a
second entry point within your gogreeter repository that used the Lambda SDK. To
then add the code to the Lambda function you had to compile the new entrypoint
into an executable and store it within a ZIP file. The ZIP file could then be
uploaded to Lambda. Code wise nothing related to your business logic changed.
You just had to change the way you get the input. In this case AWS Lambda
provides the event that caused the execution into the function. From there you
are able to get the query parameters and fallback to default values in case they
are not there. With the advanced settings section you made your function
accessible over the internet to anyone. This works because AWS in the back
creates a role that allows everyone to access it. Under the URL you copied you
will then be able to use the application the way you are used too locally.

### Clean Up

As long as your Lambda function will not go over a specific amount of requests
they will not create any costs. To still prevent the chance of this happening we
are now going to clean up the account.

1. Open the AWS Console [here](https://console.aws.amazon.com)
2. Log in with your newly created user
3. Select "Europe (Frankfurt)" next to your account name
4. Search for Lambda in the upper search bar
5. In the left menu select "Functions"
6. Select both functions
7. Under "Actions" click "Delete"
8. Type "delete" and click "Confirm"
9. Click "Close"
10. Search for IAM in the upper search bar
11. Click "Policies" under "Access Management"
12. Search for "AWSLambdaBasicExecutionRole" under "Policies"
13. For each result click onto the "+"
14. If it contains either py- or gogreeter click "Delete" under "Actions"

The account should now be back to the original state. You can use it to checkout
the [free tiers](https://aws.amazon.com/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all)
of other services or if you do not need it anymore delete it with [the following](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-closing.html)
instructions. If you continue using the account please add [MFA authentication](https://docs.aws.amazon.com/IAM/latest/UserGuide/enable-virt-mfa-for-root.html)
and create an [IAM user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)
immediately.

## 12. Deploy to Exoscale with IaC

In this exercise you are going to deploy your applications in virtual machines
behind a load balancer with the help of OpenTofu and Ansible on Exoscale.
Exoscale was really nice to provide you with 50.- of credits on their platform.
Follow the instructions within Slack to receive the credits. You are then able
to use this account for the following exercise and the remaining credits for
whatever you would like to try out on Exoscale. There is just one rule, **do not
create more than one SKS cluster**. As soon as you have an account we will have
to create an API key for OpenTofu to create the resources.

1. Open the portal of Exoscale [here](https://portal.exoscale.com)
2. Click on "IAM" on the left side
3. Click on "Roles" in the sub menu
4. Click "Add"
5. As a name use "SysAdmin"
6. Click "Create"
7. Click on "Keys" in the sub menu
8. As name use "OpenTofu"
9. Select the previously created "SysAdmin" role
10. Click "Create"
11. Write down your key and secret in a secure place (you will not be able to
    see the secret again after leaving the page)

### Creating a OpenTofu Module for the Infrastructure

1. Create a new folder named `greeting-infrastructure`
2. Create a file named `configuration.tf`
3. Add the following content

   ```tf
   terraform {
     required_providers {
       exoscale = {
         source = "exoscale/exoscale"
         version = "0.54.1"
       }
     }
   }
   ```

4. Initialize OpenTofu

   ```bash
   tofu init
   ```

5. Within this folder create a folder named `instance-pool-behind-loadbalancer`
6. Create a file named `variables.tf` within the new folder
7. Add the following content within the `variables.tf` file to define variables.
   The first contains the name to use as a prefix for the resources, the second
   one contains the zone to use within the module, the third contains the ssh
   public key that should be installed on the instances, the fourth contains
   ports that should be allowed on the security group, the sixth contains the
   amount of instances to create, the fifth contains the type of instance to
   create and the final one the amount of disk space to provision for each
   instance.

   ```tf
   variable "name" {
     type = string
   }

   variable "zone" {
     type    = string
     default = "ch-dk-2"
   }

   variable "ssh_public_key" {
     type = string
   }

   variable "security_group_allowed_ports" {
     type    = set(string)
     default = ["22", "80"]
   }

   variable "instance_count" {
     type    = number
     default = 2
   }

   variable "instance_type" {
     type    = string
     default = "standard.tiny"
   }

   variable "instance_disk_size" {
     type    = number
     default = 10
   }
   ```

8. Create an SSH Key to access the virtual machines

   ```bash
   ssh-keygen
   ```

   Store the key under the name `id_exoscale` in the `.ssh` folder within your
   home directory.

9. Create a file named `main.tf` within the new folder
10. Add the following content to create the `exoscale_ssh_key` resource

    ```tf
    resource "exoscale_ssh_key" "instance_ssh_key" {
      name       = "${var.name}-instance-ssh-key"
      public_key = var.ssh_public_key
    }
    ```

11. Create a `exoscale_security_group` resource that will manage the access to
    the instances within the `main.tf` file.

    ```tf
    resource "exoscale_security_group" "greeters_security_group" {
      name = "${var.name}-greeters-security-group"
    }
    ```

12. Create two `exoscale_security_group` resources that will configure the
    security group to allow traffic on specific ports.

    ```tf
    resource "exoscale_security_group_rule" "greeters_security_group_rule" {
      security_group_id = exoscale_security_group.greeters_security_group.id
      for_each          = var.security_group_allowed_ports
      type              = "INGRESS"
      protocol          = "TCP"
      cidr              = "0.0.0.0/0"
      start_port        = tonumber(each.key)
      end_port          = tonumber(each.key)
    }
    ```

13. Create a `exoscale_template` data source to access one of the default
    instance templates within the `main.tf` file. The template can then be used
    to create instances.

    ```tf
    data "exoscale_template" "ubuntu" {
      name = "Linux Ubuntu 22.04 LTS 64-bit"
      zone = var.zone
    }
    ```

14. Create a `exoscale_instance_pool` resource that will create a specific
    amount of instances within the `main.tf` file.

    ```tf
    resource "exoscale_instance_pool" "greeters" {
      name = "${var.name}-greeters"
      zone = var.zone

      template_id        = data.exoscale_template.ubuntu.id
      instance_type      = var.instance_type
      disk_size          = var.instance_disk_size
      size               = var.instance_count
      key_pair           = exoscale_ssh_key.instance_ssh_key.name
      security_group_ids = [exoscale_security_group.greeters_security_group.id]
    }
    ```

15. Create a `exoscale_nlb` resource that will create a network load balancer
    within the `main.tf` file.

    ```tf
    resource "exoscale_nlb" "greeters_nlb" {
      name = "${var.name}-greeters-nlb"
      zone = var.zone
    }
    ```

16. Create a `exoscale_nlb_service` resource that will configure the network
    load balancer to actually split the traffic across your instances within
    the `main.tf` file.

    ```tf
    resource "exoscale_nlb_service" "greeters_nlb_service" {
      name   = "${var.name}-greeters-nlb-service"
      zone   = exoscale_nlb.greeters_nlb.zone
      nlb_id = exoscale_nlb.greeters_nlb.id

      instance_pool_id = exoscale_instance_pool.greeters.id
      port             = 8080
      target_port      = 8080

      healthcheck {
        port = 8080
        mode = "http"
        uri  = "/"
      }
    }
    ```

17. Create a file named `outputs.tf`
18. Add the following outputs within the `outputs.tf` file.

    ```tf
    output "nlb_ip_address" {
        value = exoscale_nlb.greeters_nlb.ip_address
    }

    output "instance_ip_addresses" {
        value = exoscale_instance_pool.greeters.instances[*].public_ip_address
    }
    ```

19. Create a file named `main.tf` in the upper folder
20. Create a file named `variables.tf` in the upper folder
21. Add the following variable to the newly created `variables.tf` file

    ```tf
    variable "ssh_public_key" {
      type = string
    }
    ```

22. Create a file named `outputs.tf` in the upper folder

### pygreeter

1. Add the newly created module within the `main.tf` file and pass the name
   `pygreeter` and the variable `ssh_public_key` to it.

   ```tf
   module "gogreeter" {
     source         = "./instance-pool-behind-loadbalancer"
     name           = "gogreeter"
     ssh_public_key = var.ssh_public_key
   }
   ```

2. Create two outputs within the `outputs.tf` file.

   ```tf
   output "pygreeter_nlb_ip_address" {
       value = module.pygreeter.nlb_ip_address
   }

   output "pygreeter_instance_ip_addresses" {
       value = module.pygreeter.instance_ip_addresses
   }
   ```

### gogreeter

1. Add the newly created module within the `main.tf` file and pass the name
   `gogreeter` and the variable `ssh_public_key` to it.

   ```tf
   module "gogreeter" {
     source         = "./instance-pool-behind-loadbalancer"
     name           = "gogreeter"
     ssh_public_key = var.ssh_public_key
   }
   ```

2. Create two outputs within the `outputs.tf` file.

   ```tf
   output "gogreeter_nlb_ip_address" {
       value = module.gogreeter.nlb_ip_address
   }

   output "gogreeter_instance_ip_addresses" {
       value = module.gogreeter.instance_ip_addresses
   }
   ```

### Create the Infrastructure

1. Reinitialize OpenTofu

   ```bash
   tofu init
   ```

2. Set the previously created API key and secret as environmental variable
   (replace the KEY and SECRET after the equal sign)

   ```bash
   export EXOSCALE_API_KEY=KEY
   export EXOSCALE_API_SECRET=SECRET
   ```

3. Get the plan from OpenTofu

   ```bash
   tofu plan
   ```

   Enter the content of `id_exoscale.pub` as `ssh_public_key`. Then make sure
   that everything looks correct and nothing is missing.

4. Apply the infrastructure

   ```bash
   tofu apply
   ```

   Enter the content of `id_exoscale.pub` as `ssh_public_key`. Type `yes` to
   create the infrastructure. Write down the outputs you get from OpenTofu.

If you commit the infrastructure as code to a VCS use [the following](https://github.com/github/gitignore/blob/main/Terraform.gitignore)
git ignore file.

### Creating an Ansible Playbook

1. Create a new folder named `greeting-infrastructure-setup`
2. Create a new file named `hosts.yaml`
3. Add the following content (replace `PYGREETER_*` and `GOGREETER_*` with the
   `instance_ip_addresses` outputs from OpenTofu, in case you do not have the
   outputs anymore execute `tofu output`)

   ```yaml
   ---
   py:
     hosts:
       py01:
         ansible_host: "PYGREETER_IP_1"
       py02:
         ansible_host: "PYGREETER_IP_2"
   go:
     hosts:
       go01:
         ansible_host: "GOGREETER_IP_1"
       go02:
         ansible_host: "GOGREETER_IP_2"
   ```

4. Add a file named `vars.yaml`
5. Add the following content (replace SSH_PATH with the directory your
   previously created ssh key is in)

   ```yaml
   ---
   ansible_user: "ubuntu"
   ansible_ssh_private_key_file: "SSH_PATH/id_exoscale"
   ```

6. Create a file named `playbook.yaml`

### pygreeter

1. Add a play without any tasks for setting up the pygreeter application that
   includes the previously created variables and targets all the py hosts.

   ```yaml
   ---
   - name: "Set Up pygreeter"
     hosts: "py"
     vars_files:
       - "./vars.yaml"
   ```

2. Add a task that makes sure the instances are pingable

   ```yaml
   tasks:
     - name: "Ping Instance"
       ansible.builtin.ping: {}
   ```

3. Execute the playbook (trust the hosts by typing `yes`)

   ```bash
   ansible-playbook -i hosts.yaml playbook.yaml
   ```

4. Add a task to install the dependencies

   ```yaml
   - name: "Install Dependencies"
     become: true
     ansible.builtin.apt:
       pkg:
         - "acl"
         - "python3"
         - "python3-pip"
       update_cache: true
   ```

5. Add a task to create a user that will execute the application

   ```yaml
   - name: "Create a User"
     become: true
     ansible.builtin.user:
       name: "pygreeter"
   ```

6. Add a task to clone the git repository of pygreeter (replace USER with your
   GitHub username)

   ```yaml
   - name: "Clone the pygreeter Repository"
     become: true
     become_user: "pygreeter"
     ansible.builtin.git:
       repo: "https://github.com/USER/pygreeter.git"
       dest: "/home/pygreeter/app"
       version: "main"
   ```

7. Add a task to install the python requirements

   ```yaml
   - name: "Install Python Requirements"
     become: true
     become: "pygreeter"
     ansible.builtin.pip:
       requirements: "/home/pygreeter/app/requirements.txt"
   ```

8. Create the pygreeter service in the file `pygreeter.service`

   ```text
   [Unit]
   Description=Service of pygreeter
   After=multi-user.target

   [Service]
   Type=simple
   ExecStart=python3 /home/pygreeter/app/main.py
   User=pygreeter

   [Install]
   WantedBy=multi-user.target
   ```

9. Add a task to create the service file

   ```yaml
   - name: "Create the pygreeter Service"
     become: true
     ansible.builtin.copy:
       src: "./pygreeter.service"
       dest: "/usr/lib/systemd/system/pygreeter.service"
       owner: "root"
       group: "root"
   ```

10. Add a task to start the newly created service

    ```yaml
    - name: "Start the pygreeter Service"
      become: true
      ansible.builtin.systemd_service:
        name: "pygreeter.service"
        state: "started"
        daemon_reload: true
    ```

11. Let Ansible do the setup for you

    ```bash
    ansible-playbook -i hosts.yaml playbook.yaml
    ```

Your application is now setup and reachable on port 8080 of the instances. The
network load balancer you created will start to balance the traffic to the
instances as soon as the health check becomes successful. Wait 5 minutes and
then open the IP address of your pygreeter network load balancer on port 8080 in
the browser. You should see the already known greeting.

### gogreeter

1. Add a play without any tasks for setting up the gogreeter application that
   includes the previously created variables and targets all the go hosts.

   ```yaml
   - name: "Set Up gogreeter"
     hosts: "go"
     vars_files:
       - "./vars.yaml"
   ```

2. Add a task that makes sure the instances are pingable

   ```yaml
   tasks:
     - name: "Ping Instance"
       ansible.builtin.ping: {}
   ```

3. Execute the playbook (trust the hosts by typing `yes`)

   ```bash
   ansible-playbook -i hosts.yaml playbook.yaml
   ```

4. Add a task to install the dependencies

   ```yaml
   - name: "Install Dependencies"
     become: true
     ansible.builtin.apt:
       pkg:
         - "acl"
         - "golang-go"
       update_cache: true
   ```

5. Add a task to create a user that will execute the application

   ```yaml
   - name: "Create a User"
     become: true
     ansible.builtin.user:
       name: "gogreeter"
   ```

6. Add a task to clone the git repository of gogreeter (replace USER with your
   GitHub username)

   ```yaml
   - name: "Clone the gogreeter Repository"
     become: true
     become_user: "gogreeter"
     ansible.builtin.git:
       repo: "https://github.com/USER/gogreeter.git"
       dest: "/home/gogreeter/app"
       version: "main"
   ```

7. Add a task to build the gogreeter application

   ```yaml
   - name: "Build the gogreeter Application"
     become: true
     become_user: "gogreeter"
     ansible.builtin.command:
       cmd: "go build -o ./bin/gogreeter ./cmd/gogreeter"
       chdir: "/home/gogreeter/app"
       creates: "/home/gogreeter/app/bin/gogreeter"
   ```

8. Create the gogreeter service in the file `gogreeter.service`

   ```text
   [Unit]
   Description=Service of gogreeter
   After=multi-user.target

   [Service]
   Type=simple
   ExecStart=/home/gogreeter/app/bin/gogreeter
   User=gogreeter

   [Install]
   WantedBy=multi-user.target
   ```

9. Add a task to create the service file

   ```yaml
   - name: "Create the gogreeter Service"
     become: true
     ansible.builtin.copy:
       src: "./gogreeter.service"
       dest: "/usr/lib/systemd/system/gogreeter.service"
       owner: "root"
       group: "root"
   ```

10. Add a task to start the newly created service

    ```yaml
    - name: "Start the gogreeter Service"
      become: true
      ansible.builtin.systemd_service:
        name: "gogreeter.service"
        state: "started"
        daemon_reload: true
    ```

11. Let Ansible do the setup for you

    ```bash
    ansible-playbook -i hosts.yaml playbook.yaml
    ```

Your application is now setup and reachable on port 8080 of the instances. The
network load balancer you created will start to balance the traffic to the
instances as soon as the health check becomes successful. Wait 5 minutes and
then open the IP address of your gogreeter network load balancer on port 8080 in
the browser. You should see the already known greeting.

### Deleting the Infrastructure

After finishing the exercise you can destroy the infrastructure to prevent the
creation of additional costs. As we only used Ansible for the application
configuration we can destroy the infrastructure with OpenTofu only.

1. Switch into the `greeting-infrastructure` folder
1. Destroy the infrastructure

   ```bash
   tofu destroy
   ```

## 13. Collect Greeting Metrics

In this exercise you are going to collect metrics about the greeting behavior
of your greeting services.

### pygreeter

To have the information related to the greetings we have to include some
Prometheus specific code into our business logic.

1. Switch into the `pygreeter` folder
2. Activate the virtual environment

   ```bash
   source .venv/bin/activate
   ```

3. Install the `prometheus-client` dependency

   ```bash
   pip install prometheus-client
   ```

4. Freeze the dependencies

   ```bash
   pip freeze > requirements.txt
   ```

5. Import the `Counter` from `prometheus-client` in the `greeter.py` file

   ```python
   from prometheus_client import Counter
   ```

6. Add a generic and specific counter in the `greeter.py` file after the
   imports

   ```python
   generic_counter = Counter(
       "pygreeter_greetings_generic_total", "Greetings without a name specified."
   )
   specific_counter = Counter(
       "pygreeter_greetings_specific_total", "Greetings with a name specified."
   )
   ```

7. Increase the generic counter before returning within the if statement

   ```python
   generic_counter.inc()
   ```

8. Increase the specific counter before returning

   ```python
   specificer_counter.inc()
   ```

9. Import the `make_asgi_app` function from `prometheus_client` module in the
   `main.py` file

   ```python
   from prometheus_client import make_asgi_app
   ```

10. Register the metrics endpoint in `main.py` before the entry point

    ```python
    metrics_app = make_asgi_app()
    app.mount("/metrics", metrics_app)
    ```

### gogreeter

To have the information related to the greetings we have to include some
Prometheus specific code into our business logic.

1. Switch into the `gogreeter` folder
2. Install the Prometheus dependencies

   ```bash
   go get github.com/prometheus/client_golang/prometheus
   go get github.com/prometheus/client_golang/prometheus/promauto
   go get github.com/prometheus/client_golang/prometheus/promhttp
   ```

3. Add the `prometheus` and `promauto` dependency in the imports of the
   `greeter/greeter.go` file

   ```go
   "github.com/prometheus/client_golang/prometheus"
   "github.com/prometheus/client_golang/prometheus/promauto"
   ```

4. Add a generic and a specific counter as a variable before the `Greet`
   function in the `greeter/greeter.go` file

   ```go
   var (
       genericCounter = promauto.NewCounter(prometheus.CounterOpts{
           Name: "gogreeter_greetings_generic_total",
           Help: "Greetings without a name specified.",
       })
       specificCounter = promauto.NewCounter(prometheus.CounterOpts{
           Name: "gogreeter_greetings_specific_total",
           Help: "Greetings with a name specified.",
       })
   )
   ```

5. Increase the generic counter before returning within the if statement

   ```go
   genericCounter.Inc()
   ```

6. Increase the specific counter before returning

   ```go
   specificCounter.Inc()
   ```

7. Import the `promhttp` and `adaptor` dependencies in the imports of
   `cmd/greeter/main.go`

   ```go
   "github.com/gofiber/fiber/v2/middleware/adaptor"
   "github.com/prometheus/client_golang/prometheus/promhttp"
   ```

8. Register the metrics endpoint after the first `Get` call

   ```go
   app.Get("/metrics", adaptor.HTTPHandler(promhttp.Handler()))
   ```

### Prometheus Configuration

For Prometheus to be aware which services to scrape metrics from you have to
setup a configuration file.

1. Create a new folder named `greeting-observability`
2. Create a file named `prometheus.yaml`
3. Add the following content

   ```yaml
   global:
     scrape_interval: "5s"
     evaluation_interval: "5s"

   scrape_configs:
     - job_name: "pygreeter"
       static_configs:
         - targets:
             - "pygreeter:8080"
     - job_name: "gogreeter"
       static_configs:
         - targets:
             - "gogreeter:8080"
   ```

### Prometheus Setup

Now we want to actually start Prometheus amongst the applications. To do that
you have to setup a container compose file.

1. Within the `greeting-observability` folder create a file named `compose.yaml`
2. Make sure you have the latest container images that have been built by your
   CI/CD or manually (replace USER with your GitHub username)

   ```bash
   podman pull ghcr.io/USER/pygreeter
   podman pull localhost:8082/gogreeter
   ```

3. Add the following content (replace USER with your GitHub username)

   ```yaml
   version: "3"
   services:
     prometheus:
       image: "prom/prometheus"
       ports:
         - "9090:9090"
       volumes:
         - "./prometheus.yaml:/etc/prometheus/prometheus.yml"
     pygreeter:
       image: "ghcr.io/USER/pygreeter"
       ports:
         - "9091:8080"
     gogreeter:
       image: "localhost:8082/gogreeter"
       ports:
         - "9092:8080"
   ```

4. Access both pygreeter and gogreter on http://localhost:9091 or
   http://localhost:9092 and provide the name query parameter in some cases.
5. Open Prometheus on http://localhost:9090 and search for
   `pygreeter_greetings_generic_total or gogreeter_greetings_generic_total`
6. Click on Graph

You know see the history of counter increasing thanks to Prometheus.

## 14. Creating Alerts

In this exercise you are going to create an alert based on the previously
created metrics. For that you are going to add Alertmanager to the container
compose file and then define conditions that are forwarded to Alertmanager which
then sends it to a service which just logs the request body.

### Configure an Alert Condition

In this specific case you are going to create an Alert if the count of generic
greetings within a minute was more than 5. This is because we want other
applications to mainly use our service with a name specified and catch
not configured services using our API (be aware that this is a made up example
that does not necessarily have to make sense).

1. Open the `prometheus.yaml` file
2. Add the following config

   ```yaml
   alerting:
     alertmanagers:
       - static_configs:
           - targets:
               - "alertmanager:9093"

   rule_files:
     - "/etc/prometheus/rules.yml"
   ```

3. Create a file named `rules.yaml`

   ```yaml
   groups:
     - name: "Greetings"
       rules:
         - alert: "GenericOverSpecific"
           expr: "sum(increase(gogreeter_greetings_generic_total[1m])) > 5"
         - alert: "GenericOverSpecific"
           expr: "sum(increase(pygreeter_greetings_generic_total[1m])) > 5"
   ```

4. Include the file within the volumes section of the `prometheus` service in
   the `compose.yaml` file

   ```yaml
   - "./rules.yaml:/etc/prometheus/rules.yml"
   ```

### Add an HTTP Logger

1. Open the `compose.yaml` file
2. Add the following service

   ```yaml
   httplogger:
     image: "bfosberry/http-logger"
   ```

### Add Alertmanager

1. Create a file named `alertmanager.yaml`
2. Add the following content

   ```yaml
   route:
     receiver: "httplogger"

   receivers:
     - name: "httplogger"
       webhook_config:
         url: "http://httplogger:8090"
   ```

3. Open the `compose.yaml` file
4. Add the following service

   ```bash
   alertmanager:
     image: "quay.io/prometheus/alertmanager"
     ports:
       - "9093:9093"
     volumes:
       - "./alertmanager.yaml:/etc/alertmanager/alertmanager.yml"
   ```

You can now open pygreeter (http://localhost:9091) and gogreeter
(http://localhost:9092) in your browser. Refresh both services at least 5 times
within a short amount of time. Then open Alertmanager (http://localhost:9093)
where you should see an alert. Finally, check the logs of your Podman compose
where you should see the output sent to the receiver after some time.

## 15. Create a Dashboard

In this exercise you are going to visualize the metrics and alerts within
Grafana. For this you will first add Grafana to your observability stack and
then create two dashboards that contain a comparison between generic and
specific greetings and an alert overview.

### Add Grafana

1. Open the file named `compose.yaml`
2. Add the following service

   ```yaml
   grafana:
     image: "grafana/grafana-enterprise"
     ports:
       - "3000:3000"
   ```

3. Open Grafana on http://localhost:3000
4. Login as the user `admin` with password `admin`
5. Change the password

### Configure Prometheus Connection

1. Click on the burge menu next to "Home"
2. Click on "Connections"
3. Click "Add new connection"
4. Select "Prometheus"
5. Click "Add new data source"
6. As name enter "Prometheus"
7. Under "Connection" enter "http://prometheus:9090" as "Prometheus server URL"
8. Click "Save & test"

### pygreeter

1. Click "+" on the top right
2. Click "New dashboard"
3. Click "Add visualization"
4. Select "Prometheus" as data source
5. Click "Time series"
6. Select "Stat" as type
7. On the right name the pane "Comparison"
8. Under "Thresholds" delete the one for "80"
9. In the "Query" named "A" select the metric "pygreeter_greetings_generic_total"
10. Click "Options"
11. Switch "Legend" to "Custom"
12. Enter "Generic" as "Legend"
13. Click "Add query"
14. In the "Query" named "B" select the metric
    "pygreeter_greetings_specific_total"
15. Click "Options"
16. Switch "Legend" to "Custom"
17. Enter "Specific" as "Legend"
18. Click "Apply" on the top right
19. Click "Add"
20. Click "Visualization"
21. Click "Time series"
22. Select "Alert list" as type
23. On the right name the pane "Alerts"
24. Click "Apply" on the top right
25. Click the save icon and as title user "pygreeter"

### gogreeter

1. Click "+" on the top right
2. Click "New dashboard"
3. Click "Add visualization"
4. Select "Prometheus" as data source
5. Click "Time series"
6. Select "Stat" as type
7. On the right name the pane "Comparison"
8. Under "Thresholds" delete the one for "80"
9. In the "Query" named "A" select the metric "gogreeter_greetings_generic_total"
10. Click "Options"
11. Switch "Legend" to "Custom"
12. Enter "Generic" as "Legend"
13. Click "Add query"
14. In the "Query" named "B" select the metric
    "gogreeter_greetings_specific_total"
15. Click "Options"
16. Switch "Legend" to "Custom"
17. Enter "Specific" as "Legend"
18. Click "Apply" on the top right
19. Click "Add"
20. Click "Visualization"
21. Click "Time series"
22. Select "Alert list" as type
23. On the right name the pane "Alerts"
24. Click "Apply" on the top right
25. Click the save icon and as title user "gogreeter"

## 16. Trace Endpoint of Applications

In this exercise you are going to add tracing to your application. For that you
will first have to add tracing to your observability stack and then use the
OpenTelemetry SDK within your applications.

### Add Jaeger

1. Open the file named `compose.yaml`
2. Add the following service

   ```yaml
   jaeger:
     image: "jaegertracing/all-in-one"
     environment:
       - "COLLECTOR_ZIPKIN_HOST_PORT=:9411"
     ports:
       - "6831:6831/udp"
       - "6832:6832/udp"
       - "5778:5778"
       - "16686:16686"
       - "4317:4317"
       - "4318:4318"
       - "14250:14250"
       - "14268:14268"
       - "14269:14269"
       - "9411:9411"
   ```

### pygreeter

### gogreeter
