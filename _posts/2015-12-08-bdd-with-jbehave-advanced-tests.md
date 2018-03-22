---
title: 'BDD with JBehave (2/2): Advanced tests'
layout: post
categories:
  - Coding
tags:
  - BDD
  - Java
  - JBehave
  - TDD
series:
  - BDD with JBehave
---
This entry is part 2 of 2 in the series _BDD with JBehave_.

In the previous article about BDD with JBehave, we learned about how to create a test using the JBehave story pattern that describes preconditions, events and the expected behavior. Due to its natural language, the story can even be understood by non-technical users. The test described the behavior of a digital radio when the on/off switch is being pressed.

This test was very basic, but sufficient to illustrate the basic functionality. More often however, it is neccessary to describe behavior in a more complex manner, e.g. by specifying and evaluating parameters, chaining preconditions and so on.

In this second part of the article series about BDD and JBehave we will explore some of the more advanced functionalities of JBehave to create more sophisticated behavior driven tests.

# Parameterized Tests

When describing events and expected behavior, it is often useful to evaluate certain parts of the expectation description in the story. We did this implicitly before by stating the following expectation

{% highlight %}
Then the radio should be turned on```
{% endhighlight %}

and evaluating the expecation in Java to a boolean:

{% highlight java %}
assertTrue(radio.isTurnedOn());
{% endhighlight %}

But what if we wanted to evaluate the expectation in a more complex manner, e.g. by specifying the following test:

For this test we need to evaluate a part of the `When...` part of the story in Java to use it to set the frequency (`103.8`) of the radio. We also have to evaluate a part of the `Then...` part of the story in Java to assert the fulfillment of our expectation (displayed value should be `103.80 FM`).

Luckily, extracting parameters from textual descriptions is not hard at all with JBehave. As you remember from part 1 of the series, it is important that the String handed over to the annotation matches the string in the story. JBehave finds the annotated Java method for a textual description by <a href="http://jbehave.org/reference/stable/annotations.html" target="_blank">regex-matching this string </a>with the one found in the story file. Since a regex is used for matching, the annotation string can contain special characters that will translate to parameter names. The parameter values can be injected in Java by specifying method arguments of the same name:

Parameters are defined as Strings in the story file, but can be any other type in Java, including object types. Type conversion is done automatically by JBehave, where possible using <a href="http://jbehave.org/reference/stable/parameter-converters.html" target="_blank">built-in parameter converters</a>. If this is not possible, you can write your own parameter converter, but this is not in scope for this article.

Usually, the method parameters carry the same names and occur in the same order as specified in the annotation string. This is good practice but there may be cases where naming and/or order of parameters in Java may be different. That&#8217;s why JBehave includes the `@Named`-annotation for parameter values:

Using the `@Named`-annotation both name and/or order of parameter can become independent of the description in the story. However, having parameter names and order the same is good practice and also less verbose. I suggest keeping them in sync unless there&#8217;s absolutely no way to avoid it.

Let's update our Radio so that the user can tune to a frequency by adding the following code:

Now run your test and voilà: The test succeeds! 🙂

# Example tables

In certain cases it can become necessary to feed different parameter values to the test in order to check different behaviour. For example: Let's assume our radio has a display which can display the current station name, but which is limited to 10 characters. If a station name is longer than 10 characters, the name should be truncated down to 7 characters and appended with three dots.

This is actually an extension of a parameterized test and can be formulated similarly in the story by using an example table:

The test will then be executed once for each row in the example table, having the parameter values set to their respective value from the table.

Let's try this out and extend our `RadioSteps.java` with appropriate methods to match the story:

Also add the following methods to `Radio.java`:

If we run our test now, it will fail with the following message:

{% highlight %}
org.junit.ComparisonFailure: 
Expected :A reall...
Actual :A really long station name which will definitely not fit into the display
{% endhighlight %}

Failure of this test is actually a good thing, since it gives us a chance to fix this and immediately check the result of our efforts &#8211; all in the name of test-driven development. 🙂 So let&#8217;s change the previously added  getDisplay()-method to the following:

Now run the test again! It should become green like a cucumber.

# Composite steps

Sometimes it can be useful to chain certain preconditions together to formulate a test. For example, let&#8217;s revisit our first test:

<pre>Given a digital radio
When I press the on/off switch
Then the radio should be turned on</pre>

Now let&#8217;s assume if the radio is already turned on, it should be turned off by pressing the on/off switch again. We can write another test, which is similar to the above, but with an additional precondition:

<pre>Given a digital radio
<strong>And the radio is already turned on</strong>
When I press the on/off switch
Then the radio should be turned off</pre>

Let&#8217;s also extend our RadioSteps.java with an additional method:

&nbsp;

The two preconditions are now chained together i.e. executed in sequence in the order given by the story file. Composition of steps can also be achieved by using the `@Composite`-annotation in Java. We could use the following test

<pre>Given <strong>the radio is already turned on</strong>
When I press the on/off switch
Then the radio should be turned off</pre>

with the following step:

The result would be identical.

&nbsp;