# finance_app (BUDGY)
Este é um aplicativo de gerenciamento financeiro desenvolvido com o framework Flutter.

### Visão Geral
BUDGY é uma ferramenta projetada para ajudar você a acompanhar suas despesas, criar orçamentos e tomar decisões financeiras mais informadas. Com uma interface intuitiva e recursos variados, nosso objetivo é simplificar o controle do seu dinheiro.

### Recursos Principais
- Registro de Despesas: Registre suas despesas diárias de forma rápida e fácil, categorizando cada transação para uma melhor análise.
- Orçamentos Personalizados: Estabeleça metas financeiras e acompanhe seu progresso ao longo do tempo com orçamentos personalizados.
- Organização em categorias: Controle sua receita e evite prejuízos ou gastos desnecessários.
- Sincronização em Nuvem: Sincronize seus dados em vários dispositivos para acessar suas informações financeiras de qualquer lugar, a qualquer momento.

### Instalação
Siga as instruções abaixo para configurar e executar o aplicativo em seu dispositivo:

#### Pré-requisitos
Certifique-se de ter o Flutter instalado. Se ainda não tiver, siga as instruções de instalação no [site oficial do Flutter](https://flutter.dev/).
#### Clonando o Repositório
Clone este repositório para o seu computador usando Git:
```
git clone https://github.com/gustaf30/finance_app.git
```
#### Instalando as Dependências
Navegue até o diretório do projeto e execute o comando abaixo para instalar as dependências:
```
cd finance_app
flutter pub get
```
#### Executando o Aplicativo
Conecte o dispositivo ou emulador Android/iOS ao computador e execute o aplicativo com o seguinte comando:
```
flutter run
```
Isso irá compilar e instalar o aplicativo no dispositivo conectado.

### Requisitos de sistema

Dart SDK Version 3.3.2 or greater.
Flutter SDK Version 3.19.4 or greater.

### Figma design

https://www.figma.com/file/FaexLZ0LIG09krkHTMUvWp/Financy-App-(Copy)?type=design&node-id=0%3A1&mode=design&t=7caaAUx3CS2esctw-1


### Estrutura do aplicativo
```
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
```

### Distribuição das atividades entre os integrantes do grupo
- William: Prototipação das telas (Figma)
- Gustavo e Maria: Desenvolvimento do design das telas e funcionalidade dos botões

### Funcionalidades faltantes
- Tratamento de variáveis
- Tratamento e feedback de erros
