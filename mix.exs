defmodule ExChimp.Mixfile do
  use Mix.Project

  @source_url "https://github.com/twined/ex_chimp"
  @version "0.2.0"

  def project do
    [
      app: :ex_chimp,
      name: "ExChimp",
      version: @version,
      elixir: "~> 1.12",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  defp package do
    [
      description: "Basic/minimal Mailchimp API client.",
      maintainers: ["Twined Networks"],
      licenses: ["MIT"],
      files: [
        "config",
        "lib",
        "test",
        "LICENSE.md",
        "mix.exs",
        "README.md",
        ".travis.yml",
        "CHANGELOG.md"
      ],
      links: %{
        Changelog: "https://hexdocs.pm/ex_chimp/changelog.html",
        GitHub: @source_url
      }
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:req, "~> 0.5 or ~> 1.0"},
      {:jason, "~> 1.0"},
      {:plug, "~> 1.0", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md": [],
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end
end
