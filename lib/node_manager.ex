defmodule NodeManager do

  def all_nodes do
    [Node.self | Node.list]
  end
  def list, do: all_nodes()

  def app_nodes(app_name) do
    case filter_nodes(app_name) do
      [] -> [Node.self]
      node_list -> node_list
    end
  end

  def random_app_node(app_name) do
    app_nodes(app_name) |> Enum.random
  end

  def send_request(app_name, module, function, params) do
    rpc_node = random_app_node(app_name)
    case result = :rpc.call(rpc_node, module, function, params) do
      {:badrpc, reason} -> {:error, "Unable to contact #{app_name} node: #{reason}"}
      _ -> result
    end
  end

  def connect do
    for tmp <- app_list() do
      {name, host} = tmp
      Node.connect :"#{name}@#{host}"
    end
  end

  defp app_list do
    Application.get_env(:node_manager, :app_list)
  end

  defp filter_nodes(app_name) do
    all_nodes()
    |> Enum.filter(fn(x) ->
      node_name = x |> Atom.to_string
      Regex.match?(~r/#{app_name}@/, node_name)
    end)
  end

end
