# Tesla HTTP client
Tesla.get("https://api.github.com/users/danilo-vieira/repos")
Tesla.get("https://viacep.com.br/ws/01001000/json/")
Tesla.get("https://viacep.com.br/ws/01001-000/json/")
Tesla.get("https://viacep.com.br/ws/00000000/json/")
Tesla.get("https://viacep.com.br/ws/123/json/")

# ViaCep client
ViaCEP.Client.get_cep_info("01001000")
ViaCEP.Client.get_cep_info("01001-000")
ViaCEP.Client.get_cep_info("00000000")
ViaCEP.Client.get_cep_info("123")
