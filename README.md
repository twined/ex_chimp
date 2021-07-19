# ExChimp

[![Build Status](https://travis-ci.org/twined/ex_chimp.svg?branch=master)](https://travis-ci.org/twined/ex_chimp)
[![Module Version](https://img.shields.io/hexpm/v/ex_chimp.svg)](https://hex.pm/packages/ex_chimp)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ex_chimp/)
[![Total Download](https://img.shields.io/hexpm/dt/ex_chimp.svg)](https://hex.pm/packages/ex_chimp)
[![License](https://img.shields.io/hexpm/l/ex_chimp.svg)](https://github.com/twined/ex_chimp/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/twined/ex_chimp.svg)](https://github.com/twined/ex_chimp/commits/master)

A simple, minimalistic Mailchimp client basically for just adding members to lists.

## Installation

The package can be installed as by adding `:ex_chimp` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_chimp, "~> 0.0.6"}
  ]
end
```

## Usage

Add to your application's config:

```elixir
config :ex_chimp, api_key: "yourapikeyhere-us12"
```

Get all lists on your account:

```elixir
ExChimp.List.all()
```

Add a member to a list:

```elixir
# With merge fields
ExChimp.List.add_member(
  "your_list_id",
  :subscribed,
  "sub@email.com",
  %{"FULL_NAME" => "Full name"}
)

# Update member
ExChimp.List.add_member(
  "your_list_id",
  :subscribed,
  "sub@email.com",
  %{"FULL_NAME" => "New Name"}
)

# With merge fields and gdpr switch
ExChimp.List.add_member(
  "your_list_id",
  :subscribed,
  "sub@email.com",
  %{"FULL_NAME" => "Full name"},
  %{"marketing_permissions" => [%{marketing_permission_id: "bb4ae547e5", enabled: true}]}
)

# To get the `marketing_permission_id` you can add a dummy member and extract from the `marketing_permissions` key in the response:
ExChimp.List.add_member("your_list_id", :subscribed, "dummy@email.com")

# Without
ExChimp.List.add_member("your_list_id", :subscribed, "sub@email.com")

# Destroy member
ExChimp.List.destroy_member("your_list_id", "member@to.destroy.com")
```

## Mix tasks

To show lists on your account:

    $ mix exchimp.lists

## Copyright and License

Copyright (c) 2015 Twined Networks

This software is released under the [MIT License](./LICENSE.md).
