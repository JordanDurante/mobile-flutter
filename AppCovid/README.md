# Gerenciamento de Clientes - Academia

Este projeto é uma aplicação para o gerenciamento de clientes de uma academia. A principal funcionalidade do sistema é armazenar e gerenciar informações de clientes, como nome, telefone, idade, altura, peso e foto de perfil. O sistema também permite a adição e edição dos dados dos clientes, bem como a visualização de uma lista de clientes cadastrados.

## Funcionalidades

- **Cadastro de Clientes**: O usuário pode cadastrar novos clientes com informações como nome, telefone, idade, altura, peso e foto de perfil.
- **Edição de Clientes**: A qualquer momento, o usuário pode editar os dados de um cliente já cadastrado.
- **Exibição da Lista de Clientes**: O sistema exibe uma lista com todos os clientes cadastrados, permitindo que o usuário visualize suas informações e edite quando necessário.
- **Foto de Perfil**: O sistema permite que o usuário tire uma foto diretamente do aplicativo ou selecione uma imagem da galeria para o perfil do cliente.
- **Persistência de Dados**: Os dados dos clientes são armazenados em um banco de dados SQLite para garantir que as informações sejam mantidas entre as execuções do aplicativo.

## Tecnologias Utilizadas

- **Flutter**: A plataforma para desenvolvimento de aplicativos móveis.
- **SQLite**: Banco de dados local para armazenar as informações dos clientes.
- **ImagePicker**: Para selecionar ou capturar imagens (foto de perfil).
- **ImageCropper**: Para cortar a imagem da foto de perfil.
- **sqflite**: Para gerenciamento do banco de dados SQLite.

## Funcionalidade do Banco de Dados

A aplicação utiliza um banco de dados SQLite para persistir os dados dos clientes. A tabela criada possui os seguintes campos:

- `id`: Identificador único do cliente (autoincrementado).
- `nome`: Nome do cliente.
- `telefone`: Número de telefone do cliente.
- `idade`: Idade do cliente.
- `altura`: Altura do cliente.
- `peso`: Peso do cliente.
- `foto`: Caminho para a foto de perfil do cliente.
