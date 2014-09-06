defmodule Stripe2qif.Mixfile do
  use Mix.Project

  def project do
    [ app: :stripe2qif,
      version: "0.2.0",
      elixir: "1.0.0-rc1",
      escript_main_module: Stripe2qif.CLI,
      deps: deps ]
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
      {:jiffy, github: "davisp/jiffy"},
      {:ex_doc, github: "elixir-lang/ex_doc"},
      {:meck, github: "eproxus/meck"},
      ]

  end
end
