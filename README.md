
# Ruby on Rails PICPAY API

API baseada no desafio do backend do PICPAY, desenvolvido para estudos em Ruby on Rails.

Veja o desafio original aqui:

https://github.com/PicPay/picpay-desafio-backend?tab=readme-ov-file
## Rodando localmente

Clone o projeto

```bash
  git clone https://github.com/rodrigosuco/pay_me_api.git
```

Instale as dependências

```bash
  bundle install
```

Configure o banco de dados

```bash
  rake db:create
  rake db:migrate
```

Inicie o servidor com uma bind para testar com Postman ou Insomnia

```bash
  rails s -b 172.17.220.89 -p 3000
```

Após intalação, crie um usuário passando os parametros numa requisição POST

```bash

  URL: 172.17.220.89:3000/users

  {
        "nome_completo": "Nome Completo",
        "cpf": "555.222.222-222",
        "email": "teste@teste.com",
        "senha": "senha6caracteres",
        "saldo": 10.00,
        "user_type": "comum" (ou "lojista")
  }
```
Crie uma transação/transferencia passando os parametros numa requisição POST

```bash

  URL: 172.17.220.89:3000/transfers

  {
  	    "user_id": 1,
        "recebedor": 5,
        "value": 2500.00
  }
```

