defmodule Mix.Tasks.Compile.Native do
  @shortdoc "Compiles native part"

  def run(_) do
    Mix.shell.info System.cmd("make share/exos_nif.so")
  end
end

defmodule ExOS.Mixfile do
  use Mix.Project

  def project do
    [ 
      app: :exos,
      version: "0.0.1",
      deps: deps,
      compilers: [:native, :elixir, :app],
      source_url: "https://github.com/glejeune/exos"
    ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    []
  end
end
