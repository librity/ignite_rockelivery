# Rocket Seat Ignite - Rockelivery

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

A restaurant management backend with Elixir and Phoenix.

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

## Setup <a name = "setup"></a>

Install `Erlang`, `Elixir` and `Phoenix`.

### Postgres

Create a postgress docker container with:

```bash
$ docker run --name postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
```

## Bash Commands <a name = "bash_commands"></a>

```bash
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
  cep: "12345678",
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

## Libs <a name = "libs"></a>

- https://github.com/phoenixframework/phoenix
- https://github.com/rrrene/credo
- https://github.com/avdi/dotenv_elixir
- https://github.com/elixir-plug/plug
- https://github.com/riverrun/pbkdf2_elixir
- https://github.com/elixir-plug/plug
- https://github.com/parroty/excoveralls

## Docs <a name = "docs"></a>

- https://elixir-lang.org/crash-course.html
- https://hexdocs.pm/phoenix/installation.html#content
- https://github.com/inotify-tools/inotify-tools/wiki
- https://hexdocs.pm/phoenix/deployment.html
- https://hexdocs.pm/plug/readme.html
- https://hexdocs.pm/ecto/Ecto.Changeset.html
- https://hexdocs.pm/pbkdf2_elixir/Pbkdf2.html
- https://hexdocs.pm/plug/readme.html

## Resources <a name = "resources"></a>

- https://www.tutorialspoint.com/elixir/elixir_lists_and_tuples.htm
- https://elixirforum.com/c/phoenix-forum
- https://stackoverflow.com/questions/201323/how-to-validate-an-email-address-using-a-regular-expression
- https://www.formget.com/regular-expression-for-email/
- https://github.com/parroty/excoveralls/blob/master/.github/workflows/tests.yml
- https://github.com/mijailr/actions_sample/blob/master/.github/workflows/elixir.yml
