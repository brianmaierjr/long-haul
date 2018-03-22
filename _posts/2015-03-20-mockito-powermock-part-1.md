---
id: 589
title: 'Mockito + PowerMock &#8211; Part 1: Simple Mocking'
date: 2015-03-20T12:15:20+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=589
permalink: /mockito-powermock-part-1/
categories:
  - Coding
  - Uncategorized
tags:
  - junit
  - mock
  - mocking
  - mockito
  - powermock
series:
  - Mockito
---
<div class="seriesmeta">
  This entry is part 2 of 3 in the series <a href="http://www.tiefenauer.info/series/mockito/" class="series-40" title="Mockito">Mockito</a>
</div>

<div class="fruitful_description_box">
  <div class="fruitful_description shadow-type-1 " id="desc-box-92">
    <span class="top_line"></span>
    
    <div class="text" style=" font-size: 40px; text-transform : uppercase; text-align: center; font-weight: 300; line-height: 1.2;">
      Simple Stubbing and Mocking 
    </div>
    
    <span class="bottom_line"></span>
  </div>
</div>

<div class="clearfix">
</div>

In this part of the tutorial you will create your first mock objects and stub out some methods so that they return the desired value.

<!--more-->

# A word about mocking

As described in <a title="Mockito + PowerMock: Part 0" href="http://www.tiefenauer.info/mockito-powermock-part-0-introduction/" target="_blank">the introduction</a>, mocks are a hollow shell for a real class. In contrast to the class being mocked, the mock&#8217;s behavior can be configured manually. Mocks are therefore a useful means of resolving dependencies of a class under test to other classes, which can contain some complex program logic. Typically, you only want to check your tested class is working as specified, assuming all referenced classes do their job as expected.

Think of a class calculating the price of a product, which has a dependency to another class which loads the product from the database. You now want to write a unit test to check if the calculations meet your expectations. What you want to test is only the calculation part, not the loading from the database. You would assume that loading the products from the database works fine, since it is tested in another class or (probably more often) implemented by a library (e.g. an OR-mapper like <a href="http://hibernate.org/" target="_blank">Hibernate</a>) that you didn&#8217;t write yourself and therefore usually don&#8217;t test yourself. Your unit test would depend on a running database instance with some valid data in it. That data would have to be set up before the test and cleaned after every test. If your test fails, it could leave your database in an unknown state, so data cleanup would become a constant pain in the ass.

Wouldn&#8217;t it be easier, if your unit test was independent of any class other than the one it tests? Wouldn&#8217;t it be nice if your tests was able to run regardless of surrounding libraries and tools used in your project and only focus on the class being tested? Mocking provides a means of achieving all this by replacing the dependency to a real object with a mocked object, which looks like the real object from the outside, but behaves exaclty the way you want it to in the different tests. As for the example above, you would mock out the class which loads the products from a database and tell the mock which Product-Objects (which can also be mocks!) to return in what case.

## Example Set-Up

The code snippets in this tutorial are based on three classes:

  1. Foo.java
  2. Bar.java
  3. FooBar.java (with dependencies to Foo and Bar)

The classes can also be found in the <a href="https://github.com/tiefenauer/MockitoExample" target="_blank">accompanying project on GitHub</a>. These classes do not contain any complex program logic and are only here to provide fields and methods to illustrate the concepts of mocking.

# Unstubbed Mocking

In its simplest form mocking consists of creating a mock and leaving it this way (i.e. not stubbing it). This means your test class compiles and your mock object has the same method signatures as a real object. However, since you have not defined any behavior, calls to those methos go to Nirvana. You may wonder how this could possibly be useful. But let me tell you that an unstubbed mock is sometimes all it needs to make a good unit test work.

Mocks can be created in two ways:

## Create a mock using annotations

Mocks can be created by applying an annotation on a member of your unit test class. The following code snipped for example would provide you with a fresh and clean mock for every single test:

## Create a mock at runtime

Mocks can also be created at runtime using the _mock()_-method. References to this mock are only visible in the method it is created. This can be convenient if you need a specific mock only in a certain test.

## Initializing mocks

Before the mocks can be used, they have to be initialized. This needs to be done because Mockito takes control over the compiled byte-code of the class and creating a child-class with the same method signatures, which works as a wrapper class that can be configured by Mockito.

Initializing the mocks can be done by either calling a static method in the JUnit test setup method:

Alternatively you can use the custom JUnit test runner that comes built-in with Mockito. To do this you have to prefix the class definition with the following annotation.

## Checking default values

When leaving the mock un-stubbed, methods will behave as follows per default:

  * Method with return type _void_: Calling the method on the mock will do nothing and (of course) return nothing
  * Method with primitive return type _int_, _long_ or _float_: Calling the method on the mock will return 0 (zero)
  * Method with primitive return type _boolean_: Calling the method on the mock will return _false_
  * Method with object return type: Calling the method on the mock will return _null_

You can check this yourself by creating a mock and then checking the return values of the un-stubbed methods.

# Simple Stubbing

Leaving the mock as it is can be enough sometimes, more often you want a mock method to return a specific value though. That value can be a real object/primitive type, but it can also be another mock.

## Stubbing methods without parameters

Methods without parameter can be set to return a specific value. In the following example, _foo_ is the mock object which is configured to return the _bar_-Object when calling _getBar() _on it. The stubbing can be done multiple times. The mock object will return the value defined in the last stubbing

## Stubbing methods with arguments

If you want to stub a method with arguments, you can do this in a similar way. Take into account that for complex types the comparison of the method parameters is done by reference. This means if you stub a method with an object-parameter, calling the method will only return the configured value when being called with <span style="text-decoration: underline;">exactly</span> the same object. If you call the method with any other object, the default value (as seen above) is being returned.

## Multiple return values

Sometimes you may want to have a method return different values for each subsequent call. This is done using the following syntax:

Please note that the last defined return value will be returned for each call after the number of configured calls has been made.

# What we have done so far

In this chapter you have learned what mocking/stubbing is good for and received a short introduction on when to use mocks. You have also seen that mock methods don&#8217;t need to be stubbed in order to use them. You have learned how to create and initialize the mocks using two alternative ways for each. Finally, you have seen how to stub methods with and without parameters so that they return one or several specific values when being called

In the next chapter, you will learn how to extend the functionality of stubbing methods with parameters by using matchers.