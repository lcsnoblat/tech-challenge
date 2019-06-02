alias ConversionApi.Transfer.Account
alias ConversionApi.Repo

Repo.insert %Account{
  name: "Lucas Noblat",
  balance: 200
}

Repo.insert %Account{
  name: "Christiano Ronaldo",
  balance: 10
}

Repo.insert %Account{
  name: "Yan Alves",
  balance: 30
}
