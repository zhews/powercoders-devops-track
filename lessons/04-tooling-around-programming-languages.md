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

--- 

## What are Dependencies?

- Usage of External Code
- Libraries
- Frameworks

---

## Example Library

```
NAME wording

FUNCTION greet(name: STRING)
    RETURN format("Hello %s!", name)
END
```

---

## Using Dependency Example

```
FROM wording IMPORT greet

greet("zhews")
```

---

## Fetching Node.js Dependency

```bash
npm install express
```

---

## Using Dependency in Node.js

```js
import express from 'express';

const app = express();
```

---

## Fetching Go Dependency

```bash
go get github.com/gofiber/fiber/v2
```

---

## Using Dependency in Go

```go
package main

import "github.com/gofiber/fiber/v2"

func main() {
    app := fiber.New()
}
```

---

## Testing

---

## What is Testing?

- Does the Code work as expected?
- Catching Bugs and Errors

---

## Example Library

```
NAME wording

FUNCTION greet(name: STRING)
    RETURN format("Hello %s!", name)
END
```

---

## Example Test

```
FROM assert IMPORT equal
FROM wording IMPORT greet

FUNCTION test_greet()
    input = "zhews"
    expected_output = "Hello zhews!"
    output = greet(input)

    equal(expected_ouput, output)
END
```

---

## Example Test Execution

```
pseudo test
```

---

## Node.js Library

```js
function greet(name) {
    return `Hello ${name}!`
}
```

---

## Test in Node.js

```js
import test from 'node:test';

import { greet } from 'wordings';

test('greet test', (t) => {
    const input = "zhews";
    const expectedOutput = "Hello zhews!";
    const ouput = greet(input);

    assert.strictEqual(expectedOutput, output);
});
```

---

## Running Tests in Node.js

```bash
node --test
```

---

## Go Library

```go
package wordings

import "fmt"

func Greet(name string) string {
    return fmt.Printf("Hello %s!", name)
}
```

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

---

## Running Tests in Go

```bash
go test ./...
```

---

## Building

---

## What is Building?

- Turning Code into an Artifact 
- Dependency
- Executable
- Distribution

---

## Building in Node.js

### ?

---

## Building in Go

```bash
go build ./cmd/example
```

---

## Running

---

## Running Code in Node.js

```bash
node example.js
```

---

## Running Code in Go

```bash
go run ./cmd/example
```

---

## Why?

---

## Learn the Basics 

- Required for any further Steps
- Processes and Tools change
    - Company
    - Team
    - Project
    - Tech Stack
