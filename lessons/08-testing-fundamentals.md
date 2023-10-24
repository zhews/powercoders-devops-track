---
title: Testing Fundamentals
---

## Agenda

- Purpose 
- Categories
- Testing Pyramid

---

## Purpose 

- Identify Errors and Bugs
- Check Requirements

<aside class="notes">
    Lets first talk about the purpose of testing. Overall it is used to identify
    errors and bugs within your software. Beside that you can also test if your
    software matches all the requirements of the customers. This can on one side
    decrease costs and on the other side keep your customers happy.
</aside>

---

## Categories

<aside class="notes">
    There are two main categories of testing. One being functional testing and
    the other one being non functional testing.
</aside>

---

## Functional Testing Types

- Unit
- Integration
- End-to-End
- ...

<aside class="notes">
    Lets start with functional testing. Functional testing assesses whether a
    application's features and functionalities work as intended, validating that
    it meets specified requirements. There are many different sub types of
    functional testing but we will quickly cover the most important ones. Unit
    testing is used to verify individual isolated components or functions. Unit
    tests focus on a specific piece of code and make sure it is working as
    intended. An example is that an addition function returns the correct result
    with many different values. The next type is integration testing. It is used
    to validate the interaction between different components or functions or in
    other words how different units work together. An example could be multiple
    different math functions that do a formula. Then there is end to end
    testing. It is used to evaluate the functionallity of the entire application
    as near possible to a real world scenario. E2E tests test the entire
    application flow from start to finish. An example for that would be to for
    example enter a math formula in form of a string and making sure that it is
    passed into the right math functions and then returns the correct result.
    But there are many more types like smoke testing, acceptance testing and so
    on.
</aside>

---

## Non-Functional Testing Types

- Load
- Usability
- Performance
- ...

<aside class="notes">
    Non-functional tests evaluate aspects of a software system that are not
    related to specific behaviors or functions, such as performance,
    scalability, and security. For example load testing is used to evaluate how
    an application performs under peak usage and if it can handle a specific
    amount of data. Then there is usability testing. It makes sure that an
    application is user friendly by checking how intuitive the interface is.
    Then there is also performance testing where the efficiency of a unit is
    evaluated and improved. But there are many more non functional testing types
    like security testing, stress testing, portability testing and so on.
</aside>

---

## Testing Pyramid

![](../assets/L08-testing-pyramid.png){ width=75% }


<aside class="notes">
    Most of the time you will propably be working on functional tests of an
    applicaiton. Because of that it is good to know about the pyramid of
    testing. The testing pyramid is a concept that represents the ideal
    distribution of different types of software tests in a pyramid shape. At the
    base of the pyramid are unit tests, forming the largest portion, followed by
    integration tests in the middle, and end-to-end tests at the top. This
    pyramid emphasizes the importance of a strong foundation with more focused
    and faster unit tests, gradually progressing to fewer but broader end-to-end
    tests to achieve a balanced and effective testing strategy.
</aside>
