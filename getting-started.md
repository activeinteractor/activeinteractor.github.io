---
title: Getting Started
layout: doc
tags: docs documentation
categories: documentation
---

# Getting Started

## Disclaimer

These docs describe version `2.0.0-alpha.x` of the gem which is in pre-release. Go [here](https://github.com/aaronmallen/activeinteractor) for information on the current version of ActiveInteractor.

## Install

Add this line to your application's Gemfile:

```ruby
gem 'activeinteractor', '2.0.0.alpha.2.3.4'
```

Or install it yourself as:

<figure class="highlight">
  <pre><span class="n">gem install activeinteractor</span></pre>
</figure>

## Basic Usage

First let's define an interactor by creating a new class that inherits from `ActiveInteractor::Interactor::Base`.

```ruby
# frozen_string_literal: true

class CreateUser < ActiveInteractor::Interactor::Base
  argument :email, String, 'The email address of the User', required: true
  argument :password, String, 'The password of the User', required: true
  argument :password_confirmation, String, 'The password confirmation of the User'

  returns :user, User, 'The created User', required: true

  def interact
    unless context.password_confirmation.present? && context.password == context.password_confirmation
      fail!(password: %i[invalid])
    end

    context.user = User.new(login: context.email, password: context.password)
    fail!(context.user.errors) unless context.user.save

    context.profile = UserProfile.new(user: user)
    fail!(context.profile.errors) unless context.profile.save
  end

  def rollback
    context.user&.destroy
    context.profile&.destroy
  end
end
```

Let's break down a couple of concepts we can see here.

### Context

#### Input Context

When you create an instance of interactor the options you pass to it are first validated and then put into an object called `context`
which can be accessed in the instance methods of your interactor.  Under the hood there are actually three different types of `context`.
The first of the three is the `ActiveInteractor::Context::Input` class which we interfaced with when we called the `argument` method in
our example above.  The `argument` method simply tells the input context what fields it should expect to have, their types, a description
and whether or not that field is required.  If a field is specified as required, or if a value passed to a field doesn't match the type
declared by the `argument` method the interactor will fail on input before our `interact` method is ever called.

#### Runtime Context

The second `context` option is the `ActiveInteractor::Context::Runtime` context which behaves much like an `OpenStruct`.  You can think of
this context object as our scratch pad.  We can declare any variables we want on it.  This is the `context` object you're actually interfacing
with in your interactor's instance methods.  After the input context passes validation we inject all of it's keys and values onto the runtime
context.  This any fields declared by the `argument` method will have their values injected into the runtime context.  You can see an example of that
below.

```ruby
# frozen_string_literal: true

class Ping < ActiveInteractor::Interactor::Base
  argument :message, String, 'A message to output to console', required: true

  def interact
    # This context object is our runtime context
    puts context.email
  end
end

Ping.perform(message: 'Hello World!')
"Hello World"
#=> <# ActiveInteractor::Result>
```

#### Output Context

The last of the three `context` objects is the `ActiveInteractor::Context::Output` object.  Much like the input context we interfaced with this
context object by using the `returns` method.  Any fields defined by the `returns` method will be placed in the returned `ActiveInteractor::Result#data`
object when an interactor runs successfully.  We'll dive in deeper on the `ActiveInteractor::Result` object later. Any fields you had on your runtime
context that are **not** declared by the `returns` method will be discarded and will not appear on the output context object.

#### Reusable Contexts

It is possible to define your `context` objects in seperate files by calling the `accepts_arguments_matching` and `returns_data_matching` methods on your
interactor. This is handy when you have a lot of interactors that accept the same arguments or return the same payloads.

```ruby
# frozen_string_literal: true

class CreateUserInput < ActiveInteractor::Context::Input
  argument :email, String, 'The email address of the User', required: true
  argument :password, String, 'The password of the User', required: true
  argument :password_confirmation, String, 'The password confirmation of the User'
end

class UserPayload < ActiveInteractor::Context::Output
  returns :user, User, 'The User', required: true
end

class CreateUser < ActiveInteractor::Interactor::Base
  accepts_arguments_matching CreateUserInput
  returns_data_matching UserPayload

  def interact
    ...
  end
end
```

## TODO

  - document `ActiveInteractor::Result`
  - document `ActiveInteractor::Interactor.perform`
  - document `ActiveInteractor::Interactor#rollback`
