defmodule Mix.Tasks.Elm.Install do
  use Mix.Task

  @shortdoc "Install Elm Packages"

  def run(packages) do
    root_dir = System.cwd!
    elm_dir = Path.join (~w(#{root_dir} web elm))
    System.cmd "elm-package",  ["install", "-y"] ++ packages, into: IO.stream(:stdio, :line), cd: elm_dir, stderr_to_stdout: true
  end
end
