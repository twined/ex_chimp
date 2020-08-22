defmodule ExChimp do
  @moduledoc """
  A simple, minimalistic Mailchimp client basically for just adding members to lists.

  ## Usage

  Add the following to your application's config:

      config :ex_chimp,
        api_key: "yourapikeyhere-us12"

  Get all lists on your account:

      ExChimp.List.all()

  Add a member to a list

      # With merge fields
      ExChimp.List.add_member("your_list_id", :subscribed, "sub@email.com", %{"FULL_NAME" => "Full name"})

      # Without
      ExChimp.List.add_member("your_list_id", :subscribed, "sub@email.com")

  """
  def config(key), do: Application.get_env(:ex_chimp, key)
end
