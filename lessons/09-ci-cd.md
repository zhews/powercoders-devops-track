---
title: CI/CD
---

## Agenda

- What is CI/CD?
- Common Stages
- Build Servers

---

## What is CI/CD?

- Automation of Software Delivery Process
- Continuous Integration
    - Early Problem Detection
    - Automated Builds
- Continuous Delivery / Continuous Deployment
    - Make Artifacts Accessible
    - User Validation
    - Releasing

<aside class="notes">
    CI/CD, or Continuous Integration/Continuous Delivery, represents a common
    set of pratices related to software development efficiency. It entails the
    automation of key processes, starting with Continuous Integration, where
    developers seamlessly integrate code changes, facilitating early issue
    detection and ensuring consistent automated builds. After that Continuous
    Delivery is used to make deployable artifacts available for stakeholders to
    do user acceptance testing. This process ensures a controlled and efficient
    release, with Continuous Deployment taking it a step further by automating
    the deployment to the production environment. In essence, CI/CD optimizes
    the software delivery pipeline.
</aside>


---

## Common Stages

<aside class="notes">
    Lets look at some common stages of CI/CD.
</aside>

---

## Configuring a Trigger

- Based on Activity in a Repository
    - Commits
    - Tagging
    - ...
- Custom Trigger
- Manual

<aside class="notes">
    At first you will have to configure something that triggers the start of the
    automation process. This is mostly some activity within a repository like
    commiting or tagging a specific commit. But it can also be a custom trigger
    like a weekly script that runs or just the manual click on start.
</aside>

---

## Check Out

- Clone Code of Repository

<aside class="notes">
    When the trigger then starts the automation process the next step that
    follows is cloning the repository containg your source code. This is know as
    the checkout phase.
</aside>

---

## Formatting

- Enforce Formatting of Code 
- Consistency
- Prevent Arguments
- Less Changes in Repository

<aside class="notes">
    Another common stage after that is formatting. This stage enforces a
    specific formatting of code. This makes sure that the code is consistent
    everywhere. It also prevents developers from argumenting if they have strong
    opinions on how to format as it is enforced by a third party e.g. the build
    server. Another important thing is that it leads to less changes in the
    repository as not everyone is always formatting it differntly.
</aside>

---

## Linting

- Best Practices in Code
- Quality and Complexity Checks
- Security Standards

<aside class="notes">
    The next stage is linting. This stage ensures that best practices are
    applied within the code. Linters also do quality and complexity checks and
    there are even linters for security standards.
</aside>

---

## Testing

- Executing all tests of Project

<aside class="notes">
    After that comes the testing stage. In this stage commonly the functonality
    tests we have talked about in the last presentation are executed
    automatically.
</aside>

---

## Building

- Create the Artifact of your Project

<aside class="notes">
    If the code passed all the quality checks it can then be built producing an
    artifact. This can either be an executable, library, container or any other
    form of distributable package. These packages depend from programming
    language to programming languages. (Talk about some common ones like npm
    package, python packages, etc.)
</aside>

---

## Pushing

- Store the Artifact in a Registry
- Based on current Branch

<aside class="notes">
    As soon as there is an artifact it can be pushed to a registry where it is
    available to everyone that needs it. If the artifact is pushed is mostly
    based on the branch it is executing on.
</aside>

---

## Deploying

- Deploy the Artifact
- Only on Approval

<aside class="notes">
    In a final stage the artifact can then be deployed to an environment. This
    is only done when there is a manual approval from a person that has enough
    rights.
</aside>

---

## Build Servers

- Central Place to execute CI/CD
- Many Different Solutions
    - GitHub Action
    - GitLab CI/CD
    - Jenkins
    - ...

<aside class="notes">
    But where are the stages we have just talked about executed? It is mostly
    done on a so called build server. A build server is a central place where
    every developer is able to execute all the steps and stages of the CI/CD
    pipelines. There are many different solutions out there. The most known ones
    are github actions, gitlab ci/cd and jenkins. We will learn more about them
    next week.
</aside>
