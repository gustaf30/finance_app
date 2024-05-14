# finance_app (BUDGY)
Este é um aplicativo de gerenciamento financeiro desenvolvido com o framework Flutter.

### Visão Geral
BUDGY é uma ferramenta projetada para ajudar você a acompanhar suas despesas, criar orçamentos e tomar decisões financeiras mais informadas. Com uma interface intuitiva e recursos variados, nosso objetivo é simplificar o controle do seu dinheiro.

### Recursos Principais
- *Registro de Despesas:* Registre suas despesas diárias de forma rápida e fácil, categorizando cada transação para uma melhor análise.
- *Organização em Categorias:* Controle sua receita e evite prejuízos ou gastos desnecessários.
- *Sincronização em Nuvem:* Sincronize seus dados em vários dispositivos para acessar suas informações financeiras de qualquer lugar, a qualquer momento.

### Novas Funcionalidades Adicionadas
- *Banco de Dados Firebase:* Integração com o Firestore para armazenamento e recuperação de transações do usuário.
- *Autenticação de Usuário:* Utilização do Firebase Authentication para autenticar os usuários e garantir a segurança dos dados.

### Instalação
Siga as instruções abaixo para configurar e executar o aplicativo em seu dispositivo:

#### Pré-requisitos
Certifique-se de ter o Flutter instalado. Se ainda não tiver, siga as instruções de instalação no [site oficial do Flutter](https://flutter.dev/).
#### Clonando o Repositório
Clone este repositório para o seu computador usando Git:

git clone https://github.com/gustaf30/finance_app.git

#### Instalando as Dependências
Navegue até o diretório do projeto e execute o comando abaixo para instalar as dependências:

cd finance_app
flutter pub get

#### Executando o Aplicativo
Conecte o dispositivo ou emulador Android/iOS ao computador e execute o aplicativo com o seguinte comando:

flutter run

Isso irá compilar e instalar o aplicativo no dispositivo conectado.

Outra possibilidade, é utilizar o Android SDK para simular um dispositivo Android em seu computador, nesse caso, recomenda-se a versão 14.0 do Android, que foi a mesma utilizada no desenvolvimento.

### Requisitos de Sistema

- Dart SDK Versão 3.3.2 ou superior.
- Flutter SDK Versão 3.19.4 ou superior.

### Figma Design

[Link para o Figma Design](https://www.figma.com/file/FaexLZ0LIG09krkHTMUvWp/Financy-App-(Copy)?type=design&node-id=0%3A1&mode=design&t=7caaAUx3CS2esctw-1)

### Estrutura do Aplicativo

├── android                         - Contém os arquivos necessários para executar o aplicativo em uma plataforma Android.
├── assets                          - Contém todas as imagens e fontes do aplicativo.
├── ios                             - Contém os arquivos necessários para executar o aplicativo em uma plataforma iOS.
├── lib                             - Pasta mais importante do aplicativo, usada para escrever a maior parte do código Dart.
    ├── main.dart                   - Ponto de partida da aplicação
    ├── core
    │   ├── app_export.dart         - Contém importações de arquivos comumente usadas
    │   ├── constants               - Contém arquivo de classe constante estática
    │   └── utils                   - Contém arquivos e utilitários comuns do aplicativo
    ├── presentation                - Contém widgets das telas
    ├── routes                      - Contém todas as rotas do aplicativo
    └── theme                       - Contém temas de aplicativos e aulas de decoração
    └── widgets                     - Contém todas as classes de widgets personalizados


### Distribuição das Atividades Entre os Integrantes do Grupo
#### Entrega 1
- William: Prototipação das telas (Figma)
- Gustavo e Maria: Desenvolvimento do design das telas e funcionalidade dos botões

#### Entrega 2
- William: Melhorias das funcionalidades implementadas na entrega 1
- Gustavo e Maria: Integração com o banco de dados, melhorias no design e adição das funções de autenticação
