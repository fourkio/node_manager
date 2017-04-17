defmodule NodeManager.Mixfile do
  use Mix.Project

  def project do
    [app: :node_manager,
     version: "0.1.0",
     elixir: "~> 1.4",
     description: "Manage node connections and communications",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["FourkIO"],
      licenses: [],
      links: %{"GitHub" => "https://github.com/fourkio/node_manager"}
    ]
  end
end
