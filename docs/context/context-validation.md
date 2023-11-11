---
title: Context Validation
layout: doc
tags: docs documentation
categories: documentation
---
# Context Validation

ActiveInteractor provides all the methods available to you in [ActiveModel::Validations](https://api.rubyonrails.org/classes/ActiveModel/Validations.html)
to run validations on your context objects.  You can call these methods directly on a context object or from your interactor with `input_<validation_method>`
or `output_<validation_method>`.

## Calling Validation Methods on a Context Object

```ruby

class CreateUserInput < ActiveInteractor::Context::Input
  argument :email, String, "The user's email address", required: true
  argument :password, String, "The user's password", required: true
  argument :password_confirmation, String, "The user's password confirmation", required: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, confirmation: true
end
```

## Calling Validation Methods on an Interactor

```ruby

class CreateUser < ActiveInteractor::Interactor::Base
  argument :email, String, "The user's email address", required: true
  argument :password, String, "The user's password", required: true
  argument :password_confirmation, String, "The user's password confirmation", required: true

  returns :user, User, 'The created User', required: true
  returns :user_profile, User, 'The created User Profile', required: true

  input_validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  input_validates :password, confirmation: true

  def interact
    ...
  end
end
```

## Built in Validations

It is almost never necessary to validate `presence` or the type of a context attribute as this is handled by default.  When a context attribute is declared as `required` ActiveInteractor will automatically ensure either a value or a default value is present.  Additionally ActiveInteractor will automatically ensure the value returned by a context attribute is the value declared.

```ruby

class CreateUserInput < ActiveInteractor::Context::Input
  argument :email, String, "The user's email address", required: true
  ...
end

context = CreateUserInput.new
context.valid?
#=> false
context.errors.full_messages
#=> ["Email can't be blank"]

context = CreateUserInput.new(email: true)
context.valid?
#=> false
context.errors.full_messages
#=> ["Email is invalid"]
```
