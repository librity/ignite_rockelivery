# Tesla HTTP client
Tesla.get("https://api.github.com/users/danilo-vieira/repos")
Tesla.get("https://viacep.com.br/ws/01001000/json/")
Tesla.get("https://viacep.com.br/ws/01001-000/json/")
Tesla.get("https://viacep.com.br/ws/00000000/json/")
Tesla.get("https://viacep.com.br/ws/123/json/")

# ViaCep client
Rockelivery.ViaCep.Client.get_cep_info("01001000")
Rockelivery.ViaCep.Client.get_cep_info("01001-000")
Rockelivery.ViaCep.Client.get_cep_info("00000000")
Rockelivery.ViaCep.Client.get_cep_info("123")
