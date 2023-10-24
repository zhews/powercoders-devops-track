---
title: Processes and Tooling around Programming Languages
---

## Agenda

- Fetching Dependencies
- Testing
- Building
- Running
- Why?

---

## Fetching Dependencies

<aside class="notes">
    One of the first things you will be doing in almost every bigger application
    is fetching some dependencies.
</aside>

--- 

## What are Dependencies?

- Usage of External Code
- Libraries
- Frameworks

<aside class="notes">
    But what are dependencies? Dependencies are the usage of external code
    within your application, for example libraries or frameworks. Almost every
    programming language has a way of doing this its own way. Important is that
    it is known which version of a dependency is used to ensure the same output
    on every device.
</aside>

---

## Example Library

```
NAME greeter

FUNCTION greet(name: STRING)
    RETURN format("Hello %s!", name)
END
```

<aside class="notes">
    To better explain dependencies look at this pseudo code. It is a library
    called greeter with a single function named greet. This function takes one
    argument called name with the type string. It then returns the name within
    a greeting sentence.
</aside>

---

## Using Dependency Example

```
FROM greeter IMPORT greet

greet("zhews")
```

<aside class="notes">
    In my application I then use the library like this. But to achieve this we
    need a way to get the code into my application and this is what we call
    fetching dependencies.
</aside>

---

## Fetching Python Dependency

```shell
pip install fastapi
```

<aside class="notes">
    To fetch a dependency in python you can use the tool called pip. Spelled out
    pip means python package installer. It will make sure that all the required
    things are available for your application. But there are different ways like
    using conda or poetry so be aware of the things your future project is
    using.
</aside>

---

## Using Dependency in Python

```python
from fastapi import FastAPI

app = FastAPI()
```

<aside class="notes">
    The dependency can then be imported and used like this. 
</aside>

---

## Fetching Go Dependency

```shell
go get github.com/gofiber/fiber/v2
```

<aside class="notes">
    In GoLang dependencies can be fetched with the tool also used for running
    the application. It will make sure that all the required things are
    available for your application and correctly documented within the go
    specific file in your application. Some time ago Go did not have a built in
    way to fetch dependencies and you had to use different tools.
</aside>

---

## Using Dependency in Go

```go
package main

import "github.com/gofiber/fiber/v2"

func main() {
    app := fiber.New()
}
```

<aside class="notes">
    The dependency can then be imported and used like this.
</aside>

---

## Testing

<aside class="notes">
    If you are working on a task there will be almost for sure be an acceptance
    criteria that says that all tests have to be passing and the new code has to
    have tests.
</aside>

---

## What is Testing?

- Does the Code work as expected?
- Catching Bugs and Errors

<aside class="notes">
    But what are tests? It is code that tests your code. By testing we mean the
    code works as expected. If you change something and it breaks a test you
    know that you either introduced a bug, error or did not update the tests
    accordingly.
</aside>

---

## Example Library

```
NAME greeter

FUNCTION greet(name: STRING)
    RETURN format("Hello %s!", name)
END
```

<aside class="notes">
    So back to the example library from before, lets test the greet function.
</aside>

---

## Example Test

```
FROM assert IMPORT equal
FROM greeter IMPORT greet

FUNCTION test_greet()
    input = "zhews"
    expected_output = "Hello zhews!"
    output = greet(input)

    equal(expected_ouput, output)
END
```

<aside class="notes">
    We define the input and the expected output. Based on the input we create
    the actual output and compare it with the expected output. Do you see a case
    where this tests would not be enough? Explain the case of an empty string or
    a string full of whitespaces. Discuss if this should be handled by the
    greet function itself and go over to how business requirements and cleary
    defined tasks are important for these kind of questions. 
</aside>

---

## Example Test Execution

```shell
pseudo test
```

<aside class="notes">
    To run tests in our pseudo language we would have to execute the command
    pseudo test. But how does this look in different languages?
</aside>

---

## Python Library

```python
def greet(name: str) -> str:
    return f"Hello {name}!"
```

<aside class="notes">
    This code is equal to the pseudo library from before but just in Python.
</aside>

---

## Test in Python 

```python
import unittest
from greeter import greet

class TestGreeter(unittest.TestCase):
    def test_greet(self):
        input = "zhews"
        expected_ouput = "Hello zhews!"
        output = greet(input)

        self.assertEqual(output, expected_output)

if __name__ == "__main__":
    unittest.main()
```

<aside class="notes">
    To achieve the same test from before we would have to create a new file
    named test_greeter.py and create a class with the test cases for this
    specific module. In the lower end we tell python that if this file is
    executed it should run the built in unittest module.
</aside>

---

## Running Tests in Python

```shell
python -m unittest
```

<aside class="notes">
    To then execute the test you can run the unittest module. The module will
    discover all the tests within your package and execute them. Be aware there
    are many different ways to do testing in python. One often used package is
    called pytest and it can be combined with the built in module.
</aside>

---

## Go Library

```go
package wordings

import "fmt"

func Greet(name string) string {
    return fmt.Printf("Hello %s!", name)
}
```

<aside class="notes">
    This code is equal to the pseudo library from before but just in Go.
</aside>

---

## Test in Go

```go
package wordings

import "testing"

func TestGreet(t *testing.T) {
    input := "zhews"
    expectedOutput := "Hello zhews!"
    output := Greet(input)

    if expectedOuput != output {
        t.Fail()
    }
}
```

<aside class="notes">
    To achieve the same test from before we would have to create a file named
    greeter_test.go and create functions prefixed with Test that do the
    different test cases.
</aside>

---

## Running Tests in Go

```shell
go test ./...
```

<aside class="notes">
    To then run the tests you can execute the subcommand test from the Go
    binary.
</aside>

---

## Building

<aside class="notes">
    As soon as your code is tested you want to make it packaged to run on any
    device.
</aside>

---

## What is Building?

- Turning Code into an Artifact 
- Dependency
- Executable
- Distribution

<aside class="notes">
    But what does this mean? It means turning your code into an artifact. This
    artifact can be then used as a dependency, executable or distribution. A
    dependency would be what we have discussed before. An executable would be a
    file that can be used to run to application without any dependencies. And a
    distribution would be a collection of files to serve to the web.
</aside>

---

## Building in Python

### ?

<aside class="notes">
    Building cannot be easily shown with the pseudo language that is why we
    directly start with python. But why is there a question mark? Python is an
    interpreted language and because of that does not get compiled or built into
    an executable. What does interpeted language mean? The python executable
    will go through your source code line by line and then do the actual
    computations and actions. This means that the source code and environment of
    your application always has to be present for it to properly execute. This
    can be done with the help of containers but this is part of a different
    lesson.
</aside>

---

## Building in Go

```shell
go build ./cmd/example -o example
```

<aside class="notes">
    In the case of Go we can create an executable. Why? because Go is a compiled
    language meaning that the go compiler will turn the code into a standalone
    file that can be execute. This is done with the command go build and the
    place of your entrypoint.
</aside>

---

## Running

<aside class="notes">
    In the end you always want to run your code.
</aside>

---

## Running Code in Python 

```shell
python main.py 
```

<aside class="notes">
    In python this can be done with passing the entrypoint to the python
    executable.
</aside>

---

## Running Code in Go

```shell
go run ./cmd/example
# or
go build ./cmd/example -o example
./example
```

<aside class="notes">
    In go you can either pass the entrypoint to the go executable or first build
    the application and then execute the binary.
</aside>

---

## Why?

<aside class="notes">
    You may be wondering why we are teching this to you and that it is obvious.
</aside>

---

## Learn the Basics 

- Required for any further Steps
- Processes and Tools change
    - Company
    - Team
    - Project
    - Tech Stack

<aside class="notes">
    The idea behind this presentation was to make you understand the different
    phases that are generally always involved when writting code and to make you
    notice that the way it is done can differ. Because of that it is important
    to learn the basics first as they are required for any further steps in this
    track. These processes and tools change from company, team, project and even
    tech stack so it is good for you to know what has to be done.
</aside>
