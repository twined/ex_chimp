defmodule ExChimp.Mixfile do
  use Mix.Project

  @source_url "https://github.com/twined/ex_chimp"
  @version "0.0.6"

  def project do
    [
      app: :ex_chimp,
      name: "ExChimp",
      version: @version,
      elixir: "~> 1.2",
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
        "LICENSE",
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
    [applications: [:logger, :httpoison, :jason]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.10 or ~> 1.1"},
      {:jason, "~> 1.0"},
      {:exvcr, "~> 0.10", only: :test},
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
