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

Define an interactor by creating a new class that inherits from `ActiveInteractor::Interactor::Base` and implement an `#interact` method and optionally a `#rollback` method.

```ruby
# frozen_string_literal: true

class CreateUser < ActiveInteractor::Interactor::Base
  argument :email, String, 'The email address of the User', required: true
  argument :password, String, 'The password of the User', required: true
  argument :password_confirmation, String, 'The password confirmation of the User'

  returns :user, User, 'The created User', required: true

  input_validates :password, confirmation: true

  def interact
    context.user = User.new(login: context.email, password: context.password)
    fail!(context.user.errors) unless context.user.save
  end

  def rollback
    context.user&.destroy
  end
end

result = CreateUser.perform(email: 'hello@aaronmallen.me', password: 'password', password_confirmation: 'password')
result.success?
#=> true
result.data.user
#=> <#User @email='hello@aaronmallen.me'>
```
