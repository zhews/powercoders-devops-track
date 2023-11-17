# Exercise

## 1. Preparing your Device

The following command line tools are used in this exercise:

- `git`
- `gh` (optional)
- `npm`
- `node`
- `go`

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
3. Change the "Repository name" to "jsgreeter"
4. Change the "Description" to "Simple Greeting REST API in JavaScript"
5. Leave the rest as it is and click "Create repository" on the bottom right
7. Repeat these steps with "gogreeter" as "Repository name" and "Simple
   Greeting REST API in Go"



Optional: The same thing could have been done with the following GitHub CLI
commands.

```shell
gh repo create jsgreeter -d "Simple Greeting REST API in JavaScript" --public 
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

### jsgreeter 

#### Cloning the Repository

1. Open [GitHub](https://github.com/) and login with your existing account
2. Search for the "jsgreeter" on the left side and click on it
3. Copy the URL in the blue "Quick setup" box
4. Execute the following command but replace URL with the URL that you just
   copied.

    ```shell
    git clone URL
    ```

Optional: The same thing could have been done with the following GitHub CLI
command (replace USER with your GitHub username).

```shell
gh repo clone USER/jsgreeter
```

#### Initializing the Project

To continue you have to create a new Node.js package.

1. Switch into the "jsgreeter" directory

    ```shell
    cd jsgreeter
    ```

2. Set up a new package in the same directory

    ```shell
    npm init
    ```

    Use the following values for the things asked by `npm`.

    | Section | Value |
    | ------- | ----- |
    | `package name` | (hit enter) |
    | `version` | `0.1.0` |
    | `description` | `Simple Greeting REST API in JavaScript` |
    | `entrypoint` | `main.js` |
    | `test command` | (hit enter) |
    | `git repository` | `https://github.com/USER/jsgreeter` (replace USER with your GitHub username) |
    | `keywords` | (hit enter) |
    | `author` | `USER` (replace USER with your GitHub username) |
    | `license` | `UNLICENSED` |

    When `npm` asks if the values are okay hit enter.

This will create a file named `package.json` in the application directory
containing the required information for Node.js to function.

#### Create Entry Point

Next you have to create the entry point of the application or in other words the
place where the code execution will start from.

1. Create a new file named `main.js`
2. Enter the following code

    ```js
    console.log("jsgreeter");
    ```

3. Execute the entry point

    ```shell
    node main.js
    ```

After completing the final step you should see "jsgreeter" in your console.

#### Install Dependencies

There are frameworks that help you create REST APIs. These have to be installed
first and can then be imported and used.

1. Install the `express` package

    ```shell
    npm install express
    ```

#### Create Greeting Logic

The core logic of the application is greeting. You should be able to greet
someone with their name. If no name is provided you should fall back to a
generic way of greeting.

1. Create a new file named `greeter.js`
2. Create the core logic

    ```js
    function greet(name) {
        if (name.length === 0) {
            return "Hello World!"
        }
        return `Hello ${name}!`
    }

    module.exports = { greet };
    ```

#### Create REST API

To provide your service over an REST API you have to create a server with a
handler that passes the input to the core logic and then returns it to the user.
This is done with the help of the previously installed framework.

1. Replace the content of `main.js` with the following code

    ```js
    const express = require("express");
    const { greet } = require("./greeter");

    const app = express();

    app.get("/", (req, res) => {
      const name = req.query.name;
      const greeting = greet(name);
      res.send(greeting);
    })

    const port = 8080;
    app.listen(port, () => {});
    ```

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

1. Create a new file named `greeter.go`
2. Create the core logic

    ```go
    package main

    import "fmt"

    func Greet(name string) string {
        if len(name) == 0 {
            return "Hello World!"
        }
        return fmt.Sprintf("Hello %s!", name)
    }
    ```

#### Create REST API
