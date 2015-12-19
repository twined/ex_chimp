# ExChimp

A simple, minimalistic Mailchimp client.
Currently ExChimp only supports a few basic API calls.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add ex_chimp to your list of dependencies in `mix.exs`:

        def deps do
          [{:ex_chimp, "~> 0.0.1"}]
        end

  2. Ensure ex_chimp is started before your application:

        def application do
          [applications: [:ex_chimp]]
        end

## Usage

Add to your application's config:

    config :ex_chimp,
      api_key: "yourapikeyhere-us12"

Get all lists on your account:

    ExChimp.List.all

Get all members on a list:

    ExChimp.List.members("your_list_id")

Add a member to a list

    # With merge fields
    ExChimp.List.add_member("your_list_id", :subscribed, "sub@email.com", 
                            %{"FULL_NAME" => "Full name"})
    # Without
    ExChimp.List.add_member("your_list_id", :subscribed, "sub@email.com")
