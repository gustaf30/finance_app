
# bugdy_application2

### Requisitos de sistema

Dart SDK Version 3.3.2 or greater.
Flutter SDK Version 3.19.4 or greater.

### Figma design

https://www.figma.com/file/FaexLZ0LIG09krkHTMUvWp/Financy-App-(Copy)?type=design&node-id=0%3A1&mode=design&t=7caaAUx3CS2esctw-1


### Estrutura do aplicativo
Após a construção bem-sucedida, a estrutura do seu aplicativo deverá ficar assim:
                    
```
.
├── android                         - Ele contém os arquivos necessários para executar o aplicativo em uma plataforma Android.
├── assets                          - Ele contém todas as imagens e fontes do seu aplicativo.
├── ios                             - Ele contém os arquivos necessários para executar o aplicativo em uma plataforma iOS.
├── lib                             - Pasta mais importante do aplicativo, usada para escrever a maior parte do código Dart.
    ├── main.dart                   - Ponto de partida da aplicação
    ├── core
    │   ├── app_export.dart         - Ele contém importações de arquivos comumente usadas
    │   ├── constants               - Ele contém arquivo de classe constante estática
    │   └── utils                   - Ele contém arquivos e utilitários comuns do aplicativo
    ├── presentation                - Contém widgets das telas
    ├── routes                      - Contém todas as rotas do aplicativo
    └── theme                       - Ele contém temas de aplicativos e aulas de decoração
    └── widgets                     - Ele contém todas as classes de widgets personalizados
```
### Como formatar seu código?

- se o seu código não estiver formatado, execute o seguinte comando em seu terminal para formatar o código
  ```
  dart format .
  ```

### Como você pode melhorar a legibilidade do código?

Resolva os erros e avisos mostrados no aplicativo.

