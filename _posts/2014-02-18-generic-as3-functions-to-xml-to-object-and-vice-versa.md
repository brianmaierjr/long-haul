---
id: 156
title: Generic AS3-functions to convert XML to Object and vice versa
date: 2014-02-18T15:07:05+00:00
author: admin
layout: post
guid: http://www.tiefenauer.info/?p=156
permalink: /generic-as3-functions-to-xml-to-object-and-vice-versa/
frutiful_posts_template:
  - "2"
categories:
  - Coding
tags:
  - as3
  - conversion
  - xml
---
Converting an Object in AS3 to XML and vice versa, can be really tricky. Basically you have these three options:

  * Parse and deserialize yourself, mapping your XML to your own objects.
  * Use a serializer / deserializer from a library.
  * Cast as objects, use a HTTPService.

Since the first option is quite cumbersome ant the second and third option requires the use of external libraries or services, I wanted to write a simple function that can be used to convert ANY object to XML and ANY XML to a plain old object.

<!--more-->

# Converting XML to Object

The first function (`xmltobj`) the function to convert an XML String to an Object. It behaves as follows:

  * Each node in the XML will be converted to an property on the object with the same name
  * The value of the node will become the value of the property
  * If a node contains multiple sub-nodes whereas each sub-node has a numeric name (<0/>, <1/>, etc.) the node will be automatically converted to an array on the object. The order of the sub-nodes wil be reflected in the order in the array, but the node name will not determine the index in the array.

# Converting Object to XML

<span style="line-height: 1.5;">The counterpart (<code>obj2xml</code>) function to convert an Object to XML. It behaves as follows:</span>

  * each property on the object will be converted to a corresponding node on the XML
  * Simple types like String, int and Boolean will be directly taken over and no further-sub-nodes are created
  * Complex types (other objects) will be recursively added as sub-nodes
  * Arrays will be converted to XMLLists, where as the single node names will be the index in the array.

# Test Classes

Below are the sources including Unit Test classes used to test them: