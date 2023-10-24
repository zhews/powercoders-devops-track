---
title: Productive Git
---

## Agenda

- Branching Strategies
- Pull Requests
- Merge Conflicts
- Resetting and Reverting
- Conventional Commits
- Commit Signing
- Git Hooks

---

## Branching Strategies

<aside class="notes">
    Lets first look at some branching strategies. A branching strategy is a way
    to interact with the version control system when creating software.
</aside>

---

## Git Flow

![](../assets/L05-git-flow.png)

<aside class="notes">
    One commonly used branchig model is the git flow. It works by having two
    initial branches one being the main and one the develop branch. If you start
    working on a new feature you will create a new branch from the develop
    branch. As soon as the features is complete it will be merged into develop.
    Once there are enough new features on the develop branch a release branch
    will be created off the develop branch. On this release branch only release
    oriented things like bug fixes, documentation and so on are allowed to be
    added. As soon as the release branch is ready for the customers is it merged
    into main and develop. The main branch should then increase the current tag.
    In case there is a bug on the main branch a hotfix branch is created of the
    main branch. When the bug is fixed it is then merged back into main, dev and
    the current release branch (if it exists).
</aside>

---

## Trunk Based Development

![](../assets/L05-trunk-based-development.png)

<aside class="notes">
    Compared to the git flow, trunk based development tries to keep branches to
    a lowest. You create a branch named after the thing you are currently
    working on. As soon as it is done it is merged back into the main branch or
    also know as trunk. These branches shoud existing at max a couple of days.
</aside>

---

## Pull Requests

<aside class="notes">
    In the previous slide we have talked about merging a branch into branch. But
    how do you let others know that your changes are ready to be merged? It is
    done with the help of a pull request.
</aside>

---

## What are Pull Requests?

- Notify about finished Changes
- Review Code
- Discuss Implementation 

<aside class="notes">
    So what are pull requests? It is a way to notify your colleagues about
    finished changes on your git platform. Your colleagues can then review the
    code by writing comments. You can then answer the comments or call your
    colleagues for discussion. As soon as all of the reviwers approved the pull
    request you will be able to merge the changes into your target branch.
</aside>

---

## Merge Conflicts 

<aside class="notes">
    Who of you has ever experience a merge conflict before? Lets quickly discuss
    what they mean.
</aside>

---

## What are Merge Conflicts?

- Occur when Merging or Rebasing
- Changes at the same Place
- Choose the correct combination of Changes

<aside class="notes">
    Merge conflicts occur when you are mergin or rebasing a source into a target
    branch. But in the time you have created your changes on the source branch
    someone also changed something on the target branch at the exact same
    location as you. You will then have to choose the correct combination of
    changes for the code to be up to date. But to make it more clear lets look
    at an example.
</aside>

---

## Example Local Target Code

```python
def greet(name: str) -> str:
    return "Hello" + name + "!"
```

<aside class="notes">
    When you created you branch the code initialy looked like this. 
</aside>

---

## Example Remote Target Code

```python
def greet(name: str) -> str:
    return "Hello {}!".format(name)
```

<aside class="notes">
    In the meantime someone changed it to look like this.
</aside>

---

## Example Local Source Code

```python
def greet(name: str) -> str:
    return f"Hello {name}!"
```

<aside class="notes">
    Your feature changed it to look like this.
</aside>

---

## Example Conflict

```python
def greet(name: str) -> str:
<<<<<<< HEAD
    return "Hello {}".format(name)
=======
    return f"Hello {name}"
>>>>>>> feature-branch 
```

<aside class="notes">
    In case you want to merge something like this will appear in your source
    code. To solve it you can keep the changes from the target branch, your
    changes or a combination of both. It is important that in the end nothing of
    the arrows and equal signs is there anymore.
</aside>

---

## Resetting and Reverting

<aside class="notes">
    Lets say you have implemented something that introduced a bug. In this case
    you could either revert or reset to the last correct commit.
</aside>

---

## What is the difference?

- Remove existing Commits
- Add new Commit undoing Changes

<aside class="notes">
    If you reset you will remove existing commits and require permissions to
    actually push to your git system. In case of reverting you create a new
    commit that removes the changes done in your commits. Lets take a look with
    the help of an example.
</aside>

---

## Example Commits

```bash
git log
```

```
197324 add bug
249321 add greeter
342132 inital commit
```

<aside class="notes">
    These are the current commits within the repository.
</aside>

---

## Example Resetting

```bash
git reset 249321
git log
```

```
249321 add greeter
342132 inital commit
```

<aside class="notes">
    In case of resetting the commit history will look like this. As you can see
    the commit that introduced the bug is now gone.
</aside>

---

## Example Reverting

```bash
git revert 249321
git log
```

```
128412 revert bug
197324 add bug
249321 add greeter
342132 inital commit
```

<aside class="notes">
    In case of reverting the commit history will look like this. As you can see
    there is a new commit that undos the changes from the bug commit.
</aside>

---

## Conventional Commits

<aside class="notes">
    Another topics that comes up in bigger projects is conventional commits.
</aside>

---

## What are Conventional Commits?

- Convention for Commit Messages
- Automated Changelogs
- Automated Version Tagging
- Improved Commit Exploring

<aside class="notes">
    But what are conventional commits? As it says in the name it is a convention
    for commits to be more specific their message. This allows automated
    changelogs and version tagging. It also makes going through the commit
    history easier.
</aside>

---

## Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

<aside class="notes">
    The format of the conventional commit specification looks like this. Type
    can be something like feat for a new features, chore for recurring tasks,
    docs for documentation and so on. The scope can be the part of the
    application it affects like api, processing and so on. The descripiton is
    what you would normaly write. The body and footer are optional and can be
    used to describe your changes in more details or inform about breaking
    changes.
</aside>

---

## Example Commit Messages

> feat(api): add 2FA

> chore!: drop support for Internet Explorer 

> docs: update README

<aside class="notes">
    This could then look like these messages. The second message would for
    example be a breaking change and is marked through the exclamation mark.
</aside>

---

## Commit Signing

<aside class="notes">
    Another topic in bigger projects is commit signing.
</aside>

---

## What is Commit Signing

- Verifying & Signing Commits
- Know who did Commit 
- Inform that you did Commit


<aside class="notes">
    It is used to verify that someone did a commit and to inform that you did a
    commit. This is done with the help of either GPG or SSH and involves
    cryptographic signatures. You can only sign a commit by entering a password
    which makes it more trustworthy.
</aside>

---

## How to Sign and Verify Commits?

- GPG Key
- SSH Key
- Git Config


<aside class="notes">
    So how do you sign and verify commits? You will first have to either create
    a GPG or SSH Key. As soon as you have one of these you can tell git with an
    entry in its configuration to use your key to sign the commits. To verify a
    commit signature you can use the git cli.
</aside>

---

## Git Hooks

<aside class="notes">
    As a final topic we will look at git hooks.
</aside>

---

## What are Git Hooks?

- Scripts that run during different Git commands
- Automate usual manual Workflows

<aside class="notes">
    So what are git hooks? Git hooks are scripts that can run at different
    places in your git worklflow. They can then be used to automate manual
    workflows.
</aside>

---

## When can I execute Git Hooks?

- pre-commit
- commit-msg
- post-commit
- post-checkout
- pre-push
- ...

<aside class="notes">
    These are common places where the hooks are executed. But you may be asking
    how do I actually add a git hooks?
</aside>

---

## How to add Git Hooks?

```bash
cat pre-commit
```

```bash
go fmt
golangci-lint run ./...
```

```bash
chmod +x pre-commit
cp pre-commit .git/hooks
```

<aside class="notes">
    Lets look at this example. You can create a file with the name of the hook
    and add the things you would like to execute inside of there. It will be a
    shell script that gets executed. When yo uare happy with the content of your
    hook you can make it executable and add it to the hooks directory in your
    hidden git directory of the project.
</aside>
