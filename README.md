# NodeManager
A package to help manage node connections and communications

## Installation
```elixir
def deps do
  [
    {:node_manager, "~> 0.1"}
  ]
end
```

## Configuration
Configure a DNS entry for each application, and define it here:
```elixir
config :node_manager,
  app_list: %{
    email: "localhost",
    users: "localhost"
  }
```

In development, all nodes will probably be running on localhost. Your production configuration might look something like this:
```elixir
config :node_manager,
  app_list: %{
    email: "email.fourk.io",
    users: "users.fourk.io"
  }
```

When your applications boot, they need to connect to an already-running node, using `NodeManager.connect/0`. It is recommended you add this function in the `start/2` function of your Application module.

## Usage
To send a request to execute a function on another node, use the following function:
```elixir
NodeManager.send_request("ApplicationName", ApplicationName.ModuleName, :function_name, [function, parameters])
```

For example, if we wanted the `users` application to request the `email` application send an email, we should use the following:
```elixir
NodeManager.send_request("email", Email.Mailer, :send, [to, from, subject, body])
```

which would be the same as executing this on the email node
```elixir
Email.Mailer.send(to, from, subject, email)
```
