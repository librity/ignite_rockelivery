ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Rockelivery.Repo, :manual)

Mox.defmock(ViaCEP.ClientMock, for: ViaCEP.Behaviour)
