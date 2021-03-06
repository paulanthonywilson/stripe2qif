defmodule Stripe2qif.Mixfile do
  use Mix.Project

  def project do
    [ app: :stripe2qif,
      version: "0.3.0",
      elixir: "1.0.0",
      deps: deps,
      escript: escript]
  end
  
  def escript do
    [main_module: Stripe2qif.CLI]
  end

  # Configuration for the OTP application
  def application do
    [mod:
      { Stripe2qif, [] },
      applications: [:httpotion],
      ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:httpotion, github: "myfreeweb/httpotion"},
      {:jsxn, github: "talentdeficit/jsxn"},
      {:ex_doc, github: "elixir-lang/ex_doc"},
      {:meck, github: "eproxus/meck"},
      ]

  end
end
