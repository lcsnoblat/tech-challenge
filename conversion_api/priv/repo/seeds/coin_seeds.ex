alias ConversionApi.Directory.Coins
alias ConversionApi.Repo

Repo.insert %Coins{
  name: "USD",
  rate: 1
}

Repo.insert %Coins{
  name: "BRL",
  rate: 2
}

Repo.insert %Coins{
  name: "ABC",
  rate: 3
}
