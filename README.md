# ExChimp

A simple, minimalistic Mailchimp client.
Currently ExChimp only supports a few basic API calls.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add ex_chimp to your list of dependencies in `mix.exs`:

        def deps do
          [{:ex_chimp, "~> 0.0.1"}]
        end

## Usage

Add to your application's config:

```elixir
config :ex_chimp,
  api_key: "yourapikeyhere-us12"
```

Get all lists on your account:

```elixir
ExChimp.List.all
```

Get all members on a list:

```elixir
ExChimp.List.members("your_list_id")
```

Add a member to a list

```elixir
# With merge fields
ExChimp.List.add_member("your_list_id", :subscribed, "sub@email.com", 
                        %{"FULL_NAME" => "Full name"})
# Without
ExChimp.List.add_member("your_list_id", :subscribed, "sub@email.com")
```

## Mix tasks

To show lists on your account:

    $ mix exchimp.lists