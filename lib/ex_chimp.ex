defmodule ExChimp do
  @moduledoc """
  A simple, minimalistic Mailchimp client.

  Currently ExChimp only supports a few basic API calls.

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
      ExChimp.List.add_member("your_list_id", :subscribed, "sub@email.com", %{"FULL_NAME" => "Full name"})

      # Without
      ExChimp.List.add_member("your_list_id", :subscribed, "sub@email.com")

  """
  def config(key) do
    Application.get_env(:ex_chimp, key)
  end
end
