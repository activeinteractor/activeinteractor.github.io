---
title: Reusable Contexts
layout: doc
tags: docs documentation
categories: documentation
---
# Reusable Contexts

It is possible to define your `context` objects in separate files by calling the `accepts_arguments_matching` and `returns_data_matching` methods on your
interactor. This is handy when you have a lot of interactors that accept the same arguments or return the same payloads.

## Abstracting an Input Context

```ruby

class CreateUserInput < ActiveInteractor::Context::Input
  argument :email, String, 'The email address of the User', required: true
  argument :password, String, 'The password of the User', required: true
  argument :password_confirmation, String, 'The password confirmation of the User'
end

class CreateUser < ActiveInteractor::Interactor::Base
  accepts_arguments_matching CreateUserInput

  returns :user, User, 'The User', required: true

  def interact
    ...
  end
end
```

## Abstracting an Output Context

```ruby

class CreateUserPayload < ActiveInteractor::Context::Output
  returns :user, User, 'The User', required: true
end

class CreateUser < ActiveInteractor::Interactor::Base
  argument :email, String, 'The email address of the User', required: true
  argument :password, String, 'The password of the User', required: true
  argument :password_confirmation, String, 'The password confirmation of the User'

  returns_data_matching CreateUserPayload

  def interact
    ...
  end
end
```

## Abstracting Both Input and Output Context

You can of course abstract both contexts and call them both in your interactor:

```ruby

class CreateUser < ActiveInteractor::Interactor::Base
  accepts_arguments_matching CreateUserInput
  returns_data_matching CreateUserPayload

  def interact
    ...
  end
end
```

## Aliased Methods

Additionally if you prefer a more composition like approach you can use `input_context`, `input_type`, `output_context`, or `output_type` in your interactor
instead of `accepts_arguments_matching` and `returns_data_matching` respectively.

```ruby

class CreateUser < ActiveInteractor::Interactor::Base
  input_context CreateUserInput
  output_context CreateUserPayload

  def interact
    ...
  end
end
```
