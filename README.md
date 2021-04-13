# Rocket Seat Ignite - Rockelivery

[![Elixir CI](https://github.com/librity/ignite_rockelivery/actions/workflows/elixir_ci.yml/badge.svg)](https://github.com/librity/ignite_rockelivery/actions/workflows/elixir_ci.yml)

## Table of Contents

- [About](#about)
- [Endpoints](#endpoints)
- [Setup](#setup)
- [Bash Commands](#bash_commands)
- [Elixir Commands](#elixir_commands)
- [Libs](#libs)
- [Docs](#docs)
- [Resources](#resources)

## About <a name = "about"></a>

A food delivery backend made with Elixir and Phoenix.

## Endpoints <a name = "endpoints"></a>

Built-in:

- `GET` http://localhost:4000/dashboard

`Welcome`

- `GET` http://localhost:4000/api/welcome/:test

`Users`

- `GET` http://localhost:4000/api/users
- `GET` http://localhost:4000/api/users/:id
- `POST` http://localhost:4000/api/users
- `PUT` http://localhost:4000/api/users/:id
- `DELETE` http://localhost:4000/api/users/:id

`Items`

- `POST` http://localhost:4000/api/items

## Setup <a name = "setup"></a>

Install `Erlang`, `Elixir` and `Phoenix`.

### Postgres

Create a postgress docker container with:

```bash
$ docker run --name postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
```

## Bash Commands <a name = "bash_commands"></a>

```bash
# Create phoenix app without webpacker or html views
$ mix phx.new app_name --no-webpack --no-html

# Intall dependencies
$ mix deps.get

# Compile project
$ mix compile

# Generate linter config file
$ mix credo.gen.config

# Run linter
$ mix credo --strict

# Start Phoenix dev server on http://localhost:4000
$ mix phx.server

# Start your project as an Interactive Elixir session
$ iex -S mix

# List all configured routes
$ mix phx.routes

# Generate JWT secret
$ mix guardian.gen.secret
```

Ecto:

```bash
# Create and migrate database
$ mix ecto.setup

# Create a migration
$ mix ecto.gen.migration create_users_table

# Run pending migrations
$ mix ecto.migrate

# Drop and migrate databases
$ mix ecto.reset

# Drop databases
$ mix ecto.drop

# Create databases
$ mix ecto.create
```

Tests

```bash
# Run tests
$ mix test

# Run tests w/ coverage report
$ mix test --cover

# Generate coverage report w/ excoveralls
$ mix coveralls

# Generate and save coverage report as html
$ mix coveralls.html
```

## Elixir Commands <a name = "elixir_commands"></a>

Create a user:

```elixir
> user_params = %{
  name: "Luisito",
  age: 40,
  email: "luisito@example.com",
  cpf: "12345678910",
  address: "paper street 123",
  cep: "01001000",
  password: "password"
}
> Rockelivery.Users.Create.call(user_params)
```

Fetch users:

```elixir
> Rockelivery.Repo.all(Rockelivery.User)
> Rockelivery.Repo.get(Rockelivery.User, "8623cdd8-7cad-43cc-953b-c30260a349f4")

> Rockelivery.Users.Get.by_id("8623cdd8-7cad-43cc-953b-c30260a349f4")
> Rockelivery.Users.Get.by_id("8623cdd8-7cad-43cc-953b-c30260a349f8")
> Rockelivery.Users.Get.by_id("8623cdd8")

> Rockelivery.Users.GetV2.by_id("8623cdd8-7cad-43cc-953b-c30260a349f4")
> Rockelivery.Users.GetV2.by_id("8623cdd8-7cad-43cc-953b-c30260a349f8")
> Rockelivery.Users.GetV2.by_id("8623cdd8")

> Rockelivery.Users.GetV3.by_id("8623cdd8-7cad-43cc-953b-c30260a349f4")
> Rockelivery.Users.GetV3.by_id("8623cdd8-7cad-43cc-953b-c30260a349f8")
> Rockelivery.Users.GetV3.by_id("8623cdd8")
```

Update a user:

```elixir
> updated_user_params = %{
  "id" => "9a519870-ff34-40ff-b24d-a0a387c8e73a",
  "name" => "UPDATEDDDDDD",
  "age" => 40,
  "email" => "UPDATEDDDDDD@UPDATEDDDDDD.com",
  "cpf" => "UPDATEDDDDD",
  "address" => "UPDATEDDDDDD",
  "cep" => "UPDATEDD"
}
> Rockelivery.Users.Update.call(updated_user_params)
```

Delete a user:

```elixir
> Rockelivery.Users.Delete.call("8623cdd8-7cad-43cc-953b-c30260a349f4")
> Rockelivery.Users.GetV3.by_id("8623cdd8-7cad-43cc-953b-c30260a349f8")
> Rockelivery.Users.GetV3.by_id("8623cdd8")
```

Verify password:

```elixir
> {:ok, %{password_hash: hash}} = Rockelivery.Users.Get.by_id("a2a60a12-1c03-4357-b370-c78ed28a9e38")
> Pbkdf2.verify_pass("password", hash)
true
> Pbkdf2.verify_pass("badddddd", hash)
false

> params = %{
	"id" => "a2a60a12-1c03-4357-b370-c78ed28a9e38",
	"password" => "password"
}
> RockeliveryWeb.Auth.Guardian.authenticate(params)
> bad_params = %{
	"id" => "a2a60a12-1c03-4357-b370-c78ed28a9e38",
	"password" => "badddddd"
}
> RockeliveryWeb.Auth.Guardian.authenticate(bad_params)
```

Orders report:

```elixir
> Rockelivery.Orders.Report.create()
```

Tesla HTTP client:

```elixir
> Tesla.get("https://api.github.com/users/danilo-vieira/repos")
> Tesla.get("https://viacep.com.br/ws/01001000/json/")
> Tesla.get("https://viacep.com.br/ws/01001-000/json/")
> Tesla.get("https://viacep.com.br/ws/00000000/json/")
> Tesla.get("https://viacep.com.br/ws/123/json/")
```

ViaCep client:

```elixir
> ViaCEP.Client.get_cep_info("01001000")
> ViaCEP.Client.get_cep_info("01001-000")
> ViaCEP.Client.get_cep_info("00000000")
> ViaCEP.Client.get_cep_info("123")
```

Stack server:

```elixir
> {:ok, pid} = Rockelivery.Stack.start_link()
> Rockelivery.Stack.push(pid, :world)
> Rockelivery.Stack.push_async(pid, :world)
> Rockelivery.Stack.pop(pid)
> Rockelivery.Stack.pop_async(pid)
```

Enum:

```elixir
> Enum.chunk_every([1, 2, 3, 4, 5, 6, 7, 8], 3) |> Enum.flat_map(fn [_head | tails] -> tails end)
```

## Libs <a name = "libs"></a>

- https://github.com/phoenixframework/phoenix
- https://github.com/rrrene/credo
- https://github.com/avdi/dotenv_elixir
- https://github.com/elixir-plug/plug
- https://github.com/riverrun/pbkdf2_elixir
- https://github.com/elixir-plug/plug
- https://github.com/parroty/excoveralls
- https://github.com/thoughtbot/ex_machina
- https://github.com/teamon/tesla
- https://github.com/PSPDFKit-labs/bypass
- https://github.com/dashbitco/mox
- https://github.com/ueberauth/guardian

## Docs <a name = "docs"></a>

- https://elixir-lang.org/crash-course.html
- https://elixir-lang.org/getting-started/sigils.html
- https://elixir-lang.org/getting-started/mix-otp/genserver.html
- https://hexdocs.pm/elixir/master/typespecs.html
- https://hexdocs.pm/elixir/master/GenServer.html
- https://hexdocs.pm/elixir/master/Supervisor.html
- https://hexdocs.pm/phoenix/installation.html#content
- https://github.com/inotify-tools/inotify-tools/wiki
- https://hexdocs.pm/phoenix/deployment.html
- https://hexdocs.pm/plug/readme.html
- https://hexdocs.pm/ecto/Ecto.Changeset.html
- https://hexdocs.pm/ecto/Ecto.Schema.html
- https://hexdocs.pm/ecto/Ecto.Repo.html#c:stream/2
- https://hexdocs.pm/pbkdf2_elixir/Pbkdf2.html
- https://hexdocs.pm/plug/readme.html
- https://hexdocs.pm/iex/master/IEx.html#pry/0
- https://hexdocs.pm/ecto/2.2.11/associations.html#content
- https://hexdocs.pm/tesla/readme.html
- https://hexdocs.pm/bypass/Bypass.html
- https://hexdocs.pm/mox/Mox.html

### CI

- https://github.com/actions
- https://github.com/actions/starter-workflows
- https://github.com/actions/starter-workflows/blob/fc65e636f2a8e8dcc0048090ca715cd6b5d76e40/ci/elixir.yml
- https://github.com/mijailr/actions_sample/blob/master/.github/workflows/elixir.yml
- https://docs.github.com/en/actions/learn-github-actions/migrating-from-gitlab-cicd-to-github-actions#databases-and-service-containers
- https://docs.github.com/en/actions/guides
- https://docs.github.com/en/actions/managing-workflow-runs
- https://docs.github.com/en/actions/learn-github-actions
- https://docs.github.com/en/actions
- https://docs.codecov.io/docs

## Resources <a name = "resources"></a>

- https://www.tutorialspoint.com/elixir/elixir_lists_and_tuples.htm
- https://elixirforum.com/c/phoenix-forum
- https://www.formget.com/regular-expression-for-email/
- https://github.com/parroty/excoveralls/blob/master/.github/workflows/tests.yml
- https://stackoverflow.com/questions/201323/how-to-validate-an-email-address-using-a-regular-expression
- https://stackoverflow.com/questions/31990134/how-to-convert-map-keys-from-strings-to-atoms-in-elixir
- https://medium.com/@diamondgfx/debugging-phoenix-with-iex-pry-5417256e1d11
- https://elixirschool.com/en/lessons/ecto/associations/
- https://viacep.com.br/
- https://inquisitivedeveloper.com/lwm-elixir-18/
- https://www.bestrandoms.com/random-address-in-br
- https://dashbit.co/blog/mocks-and-explicit-contracts
- https://cloudless.studio/model-callbacks-in-phoenix-ecto-and-rails
- https://stackoverflow.com/questions/16506351/why-use-a-callback-instead-of-a-normal-function-call
- https://jwt.io/
- https://stackoverflow.com/questions/9560815/how-to-get-erlangs-release-version-number-from-a-shell
