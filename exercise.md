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
- `kind`
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
3. Change the project name above the picture to "Powercoders DevOps Track"
4. Click on "Create"

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
3. Change the "Repository name" to "pygreeter"
4. Change the "Description" to "Simple Greeting REST API in Python"
5. Leave the rest as it is and click "Create repository" on the bottom right
7. Repeat these steps with "gogreeter" as "Repository name" and "Simple
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

In the output you should see the last test case failing. Think about the logic we
added, why is it not returning "Hello World!"? In the greeting logic we check
for an empty but not a blank string.

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

In the output you should see the last test case failing. Think about the logic we
added, why is it not returning "Hello World!"? In the greeting logic we check
for an empty but not a blank string.

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
