defmodule ExChimp.Mixfile do
  use Mix.Project

  @version "0.0.1"
  @description "Basic Mailchimp API client."

  def project do
    [app: :ex_chimp,
     version: @version,
     elixir: "~> 1.1",
     description: @description,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     package: package,
     # Docs
     name: "ExChimp",
     docs: [source_ref: "v#{@version}",
            source_url: "https://github.com/twined/ex_chimp"]
   ]
  end

  defp package do
    [maintainers: ["Twined Networks"],
     licenses: ["MIT"],
     files: ["assets", "config", "lib", "priv", "test", "web",
             "mix.exs", "README.md", ".travis.yml", "CHANGELOG.md"],
     links: %{github: "https://github.com/twined/brando"}]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:httpoison, "~> 0.6"},
     {:poison, "~> 1.5"}]
  end
end
