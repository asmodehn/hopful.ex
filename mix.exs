defmodule Hopful.MixProject do
  use Mix.Project

  def project do
    [
      app: :hopful,
      version: "0.1.0",
      elixir: "~> 1.14",

      elixirc_options: [
        warnings_as_errors: treat_warnings_as_errors?(Mix.env())
      ],

      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "Hopful",
      source_url: "https://github.com/asmodehn/hopful.ex",
      #    homepage_url: "http://YOUR_PROJECT_HOMEPAGE",
      docs: [
        # The main page in the docs
        main: "Hopful",
        #      logo: "path/to/logo.png",
        extras: ["README.md"]
      ]
    ]
  end

  defp treat_warnings_as_errors?(:test), do: false
  defp treat_warnings_as_errors?(_), do: true

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}

        # test
        {:stream_data, "~> 0.6", only: [:dev, :test]},

      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:committee, "~> 1.0.0", only: :dev, runtime: false}
    ]
  end
end
