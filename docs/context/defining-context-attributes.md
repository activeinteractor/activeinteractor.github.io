---
title: Defining Context Attributes
layout: doc
tags: docs documentation
categories: documentation
---
# Defining Context Attributes

In order to define an attribute on your context you need to use either the `argmument` method for input context or the `returns` method for output context.  Both methods accept arguments `name`, `type`, `description`, `required: <true|false>`, and `default: <value>`.  See [ActiveInteractor::Context::Attribute#initialize](/api/activeinteractor/ActiveInteractor/Context/Attribute.html#initialize-instance_method) for an exact API reference to the method.

## Basic Attribute Decleration

```ruby

class CreateUser < ActiveInteractor::Interactor::Base
  argument :email, String, "The user's email address"
  ...

  returns :user, User, 'The created User'
end
```

## Required Attribute Decleration

```ruby

class CreateUser < ActiveInteractor::Interactor::Base
  argument :email, String, "The user's email address", required: true
  ...

  returns :user, User, 'The created User', required: true
end
```

## Default Values Attribute Decleration

```ruby

class CreateUser < ActiveInteractor::Interactor::Base
  argument :email, String, "The user's email address", required: true
  argument :roles, array(String), "The user's roles", default: ['user']

  returns :user, User, 'The created User', required: true
end
```
