# ExChimp

A simple, minimalistic Mailchimp client basically for just adding members to lists.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add ex_chimp to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:ex_chimp, "~> 0.0.6"}]
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

Add a member to a list

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

# Without
ExChimp.List.add_member("your_list_id", :subscribed, "sub@email.com")

# Destroy member
ExChimp.List.destroy_member("your_list_id", "member@to.destroy.com")
```

## Mix tasks

To show lists on your account:

    $ mix exchimp.lists
