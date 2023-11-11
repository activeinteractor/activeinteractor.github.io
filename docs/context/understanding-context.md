---
title: Context
layout: doc
tags: docs documentation
categories: documentation
---

# Context

When you create an instance of interactor, the options you pass to it are first validated and then put into an object called `context`
which can be accessed by the instance methods of your interactor.  Under the hood there are actually three different types of context.

## Input Context

The first of the three is the `ActiveInteractor::Context::Input` class which we interfaced with when we called the `argument` method in
our example above.  The `argument` method simply tells the input context what fields it should expect to have, their types, a description,
and whether or not that field is required.  If a field is specified as required or if a value passed to a field doesn't match the type
declared by the `argument` method, the interactor will fail on input before our `interact` method is ever called.

## Runtime Context

The second context object is the `ActiveInteractor::Context::Runtime` context which behaves much like an `OpenStruct`.  You can think of
this context object as our scratch pad.  We can declare any variables we want on it.  This is the context object you're actually interfacing
with in your interactor's instance methods.  After the input context passes validation, we inject all of it's keys and values onto the runtime
context.  Any fields declared by the `argument` method will have their values injected into the runtime context.  You can see an example of that
below.

```ruby
# frozen_string_literal: true

class Ping < ActiveInteractor::Interactor::Base
  argument :message, String, 'A message to output to console', required: true

  def interact
    # This context object is our runtime context
    puts context.message
  end
end

Ping.perform(message: 'Hello World!')
"Hello World"
#=> <# ActiveInteractor::Result>
```

## Output Context

The last of the three context objects is the `ActiveInteractor::Context::Output` object.  Much like the input context we interfaced with this
context object by using the `returns` method.  Any fields defined by the `returns` method will be placed in the returned `ActiveInteractor::Result#data`
object when an interactor runs successfully.  We'll dive in deeper on the `ActiveInteractor::Result` object later. Any fields you had on your runtime
context that are **not** declared by the `returns` method will be discarded and will not appear on the output context object.
