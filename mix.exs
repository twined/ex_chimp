defmodule ExChimp.Mixfile do
  use Mix.Project

  @version "0.0.3"
  @description "Basic/minimal Mailchimp API client."

  def project do
    [app: :ex_chimp,
     version: @version,
     elixir: "~> 1.2",
     description: @description,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     # Docs
     name: "ExChimp",
     docs: [source_ref: "v#{@version}",
            source_url: "https://github.com/twined/ex_chimp"]
   ]
  end

  defp package do
    [maintainers: ["Twined Networks"],
     licenses: ["MIT"],
     files: ["config", "lib", "test", "LICENSE",
             "mix.exs", "README.md", ".travis.yml", "CHANGELOG.md"],
     links: %{github: "https://github.com/twined/ex_chimp"}]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:httpoison, "~> 0.10 or ~> 1.1"},
     {:poison, "~> 1.5 or ~> 2.0 or ~> 3.1"},
     {:exvcr, "~> 0.10", only: :test}]
  end
end
