---
title: 'BDD with JBehave (1/2): Setup and basic tests'
description: First part on my tutorial on BDD
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
This entry is part 1 of 2 in the series _BDD with JBehave_.

In an earlier article series I showed how to use Mockito together with JUnit in order to write good unit tests. While this tool is good for [Test Driven Development (TDD)](https://en.wikipedia.org/wiki/Test-driven_development), it falls short when it comes to [Behavior Driven Development (BDD)](https://en.wikipedia.org/wiki/Behavior-driven_development). In this article, I&#8217;m going to introduce another tool that has caught my attention and leverages your testing facilities to make use of the BDD-paradigms. But first, let&#8217;s see what we mean when we talk about BDD.

## Preface

There are a lot of posts and tutorials about JBehave, but none have satisfied my expectations so far. If you&#8217;ve never heard of JBehave before, it might be a bit hard to start out as a complete beginner, since most of the magic is happening under the hood and not transparent to the user.

A very good introduction to JBehave can be found in [this blog post](https://blog.codecentric.de/en/2012/06/jbehave-configuration-tutorial) on Codecentric.com. However, this post takes you only to a certain point, without covering the full capabilities of JBehave. This article series is intended to pick up where Codecentric.com left off.

All code to the sample project built in this tutorial is available in my [GitHub repository](https://github.com/tiefenauer/jbehave-tutorial).

# A short introduction into BDD and JBehave

Behavior Driven Development (or BDD in short) is often referred to as the successor of Test Driven Development (TDD) and should strip away all technical details and special knowlege of how code should be tested. It does so by defining communication as central means of how collaborators should define what the system should do and what the expected result is. This also means that language becomes universally important in BDD, since not all collaborators have the same knowledge of technologies, tools and processes. BDD uses a domain-specific language (DSL) to describe behaviors of and expectations from a system.

JBehave is the link between this DSL and Java by enabling software developers to incorporate expected behavior in to their test suite and run them automatically &#8211; similar to Unit Tests but based on tests formulated in natural language. The description of expected behaviour can (or should) even come from a non-technical person with extensive knowledge of the problem domain.

Going into details of the principles of BDD and technical details JBehave would be fairly out of scope of this article series. There is a vast number of articles on BDD &#8211; read the <a href="http://behaviourdriven.org/Introduction" target="_blank">introductory article by Dan North</a> or google it if you want to know more. Also, JBehave is extensiveley documented. What this article series tries to do is to give you a general idea of how BDD tests can be written using JBehave and get you started as quickly as possible.

# Getting started with JBehave

Ok, now it&#8217;s time to get our hands dirty. Let&#8217;s build our first project which is tested following the BDD approach. For this setup we will use the following setup:

  * a [Maven](http://maven.apache.org/) project
  * [IntelliJ IDEA](https://www.jetbrains.com/idea/) (Community edition)
  * [JBehave Suppor](https://github.com/witspirit/IntelliJBehave)t installed as plugin

If you&#8217;re using another IDE, you may have to undertake additional steps. I know that there&#8217;s a [JBehave plugin for Eclipse](http://jbehave.org/eclipse-integration.html), too. However, this tutorial does only cover setup with IntelliJ.

We will use a very simple example as use case for our tests. We will write Java code which implements a digital radio. Of course we will not have a real radio (i.e. you won&#8217;t hear any sound coming out of your speakers), since we only need some code to run our test against.

The radio The radio will need a power source in order to play and should have some basic functionalities, such as:

  * playing music
  * selecting a station
  * saving a station
  * showing the currently selected station
  * &#8230; and so on

The radio will be implemented in a single class `Radio.java`, which will be tested using BDD principles. This means we will define the radio&#8217;s behaviour first, before adding any logic to the class.

## Include JBehave as a dependency

Setup your project with Maven (or directly in the IDE). Of course, in order to use the functionalities of JBehave, we must add JBehave as a dependency:

{% highlight xml %}
<dependencies>
    <dependency>
        <groupId>org.jbehave</groupId>
        <artifactId>jbehave-core</artifactId>
        <version>4.0.4</version>
    </dependency>
    <dependency>
        <groupId>org.hamcrest</groupId>
        <artifactId>hamcrest-all</artifactId>
        <version>1.3</version>
    </dependency>
</dependencies>
{% endhighlight %}

Note I have also included a dependency to [Hamcrest](http://hamcrest.org/) in order to use their really useful matchers. This should be enough for now to write our first JBehave test.

## Our first JBehave test

JBehave needs three things to run a test:

  * a story, which will describe the expected behavior of the test candidate in a user friendly manner. The story is contained in a `*.story` file.
  * a test, which contains the steps to execute the described behavior. This test is usually just a Java file with some special annotations.
  * a mapping between the story and the steps, so that JBehave knows what steps to execute for what parts of the story. This is usually a class containing a configuration to automate the test. The class can be executed as a JUnit test and output results in various formats.

### The story

Let&#8217;s start with the most simple use case. Let&#8217;s say I have a digital radio, which I want to turn on to listen to music. The expected behavior could be decribed as follows:

{% highlight bash %}
Given a digital radio
When I turn on the radio
Then the radio should be turned on
{% endhighlight %}

Easy to read, huh? This is not a free text. It is acutally code being executed by JBehave! That&#8217;s the good thing about BDD: Since the behavior is language agnostic, expectations can be formulated almost entirely in natural language. You only have to follow a basic [syntax pattern](http://jbehave.org/) with the following keywords:

  * **Given**: Decribe the starting position for the behavior (preconditions)
  * **When**: Describe what is happening in the test
  * **Then**: Describe the expected behavior

Of course there&#8217;s more and the descriptions can also be parameterized. But this should be enough for us to take in for now.

### The Steps

As said, JBehave needs the steps corresponding with the story description. This can be done using a POJO with some JBehave-annotated methods:

{% highlight java %}
public class RadioSteps {

    private Radio radio;

    @Given("a digital radio")
    public void aDigitalRadio(){
        radio = new Radio();
    }

    @When("I turn on the radio")
    public void iTurnOnTheRadio(){
        radio.switchOnOff();
    }

    @Then("the radio should be turned on")
    public void theRadioShouldBeTurnedOn(){
        assertTrue(radio.isTurnedOn());
    }
}
{% endhighlight %}

As you can see, the annotations carry the same namings like keywords described above. It is important that the string passed in as an argument matches the text following the keyword.

The more perceptive of you might have noted that we&#8217;re still missing a radio that contains the actual behavior to be tested, so let&#8217;ts add that, too:

{% highlight java %}
public class Radio {

    private String stationName;
    private boolean turnedOn;

    public Radio() {

    }

    public void switchOnOff(){
        
    }

    public boolean isTurnedOn() {
        return turnedOn;
    }
}
{% endhighlight %}

### The Mapping

Now, in order for JBehave to know what steps to execute for what parts of the story, we must provide it with some basic configuration. I won&#8217;t dig into the details of what else could be configured, but this should be enough for the moment.

{% highlight java %}
public class TurnRadioOn extends JUnitStory {
    
    @Override
    public Configuration configuration(){
        return new MostUsefulConfiguration()
                // where to find the stories
                .useStoryLoader(new LoadFromClasspath(this.getClass()))
                // CONSOLE and TXT reporting
                .useStoryReporterBuilder(new StoryReporterBuilder().withDefaultFormats().withFormats(Format.CONSOLE, Format.TXT));
    }

    // Here we specify the steps classes
    @Override
    public InjectableStepsFactory stepsFactory() {
        // varargs, can have more that one steps classes
        return new InstanceStepsFactory(configuration(), new RadioSteps());
    }

}
{% endhighlight %}

What this code does is tell JBehave the classpath to load stories from and write the results to the console in text format.

### All set

Now let&#8217;s try it out. Right click on the mapping class (`TurnRadioOn.java`) and run it as a Unit Test. You should get the following output:

{% highlight bash %}
java.lang.AssertionError
 at org.junit.Assert.fail(Assert.java:86)
 at org.junit.Assert.assertTrue(Assert.java:41)
 at org.junit.Assert.assertTrue(Assert.java:52)
 at info.tiefenauer.tutorials.jbehave.RadioSteps.theRadioShouldBeTurnedOn(RadioSteps.java:30)
 at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
 at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
 at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
...
{% endhighlight %}


Uh-oh. Our test has failed. But that&#8217;s actually a good thing, since we can fix it now and will immediately know whether our fix has produced the expected behavior. So let&#8217;s complete the `switchOnOff`-Method to simulate the radio&#8217;s behavior:

{% highlight java %}
    public void switchOnOff(){
        turnedOn = !turnedOn;
    }

{% endhighlight %}

Let&#8217;s run our test again and we should see the following test result:



### Good to know

If you&#8217;re (like me) keeping your stories and other test-related files in the test folder created by maven, you can do so but you need to tell Maven to also load your story files. By default, maven does not copy `.story` files to the classpath unless you explicitly tell it so. This can be achieved by adding additional information to the build step:

Also, JBehave will run all your stories as a single unit test by default. if you want the results of the individual tests to be shown separately and neatly like in the screenshot above, you should add a dependency to [a custom test runner like the one below](http://mvnrepository.com/artifact/de.codecentric/jbehave-junit-runner):

After that you can update your test file to be run with the custom test runner:

<pre><strong>@RunWith(JUnitReportingRunner.class)</strong>
public class TurnRadioOn extends JUnitStory {
...
}</pre>

## Congratulations!

You have just run your first BDD test using JBehave. But wait, there&#8217;s more! Let&#8217;s see how we can extend our BDD-tests in order so test behavior in a more sophisticated manner.

<div id="ffs-tabbed-2" class="ffs-tabbed-nav">
  <ul class="resp-tabs-list" data-closed="closed">
    <li>
      Setup with Maven
    </li>
  </ul>
  
  <div class="resp-tabs-container">
    <div class="fruitful_tab tab-setup-with-maven">
      <p>
        If you&#8217;re very lazy and you dont want to go over all the boilerplate code of including dependencies, creating story files, steps and mapping class, you can use one of the <a href="http://jbehave.org/reference/stable/archetypes.html">Maven archetypes provided by JBehave</a>. To do this simply choose the archetype when generating the project structure. For example, if you use the command line, you could just run
      </p>
      
      <pre>mvn archetype:generate -Dfilter=org.jbehave:jbehave</pre>
      
      <p>
        to generate your project in interactive mode and then select the <code>jbehave-simple-archetype</code> , provide your project details and then hit enter to generate a simple maven project (including a sample story and steps) that can be imported into the IDE of your choice.
      </p>
      
      <p>
        For this tutorial, we&#8217;re doing the setup by hand, to help you understand the inner workings and prerequisites needed for JBehave.
      </p>
    </div>
  </div>
</div>

<div class="clearfix">
</div>