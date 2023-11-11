---
title: Reusable Contexts
layout: doc
tags: docs documentation
categories: documentation
---
# Reusable Contexts

It is possible to define your `context` objects in separate files by calling the `accepts_arguments_matching` and `returns_data_matching` methods on your
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
