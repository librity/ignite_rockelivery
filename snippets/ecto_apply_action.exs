# Runs validations and returns User without inserting it in the database
import Ecto.Changeset
user_params = %{
  "address" => "Paper street 123",
  "age" => 40,
  "cep" => "01001000",
  "city" => "São Paulo",
  "cpf" => "12345678910",
  "name" => "Tyler Durden",
  "email" => "tyler@under.ground",
  "neighborhood" => "Sé",
  "password" => "first_rule",
  "state" => "SP",
  "street" => "Praça da Sé"
}
user_params |> Rockelivery.User.changeset() |> apply_action(:create)

bad_params = %{
  "name" => "Luisito",
  "age" => 15,
  "email" => "luisito@example.com",
  "cpf" => "12345678910",
  "address" => "paper street 123",
  "cep" => "01001000",
  "password" => "password"
}
bad_params |> Rockelivery.User.changeset() |> apply_action(:create)
