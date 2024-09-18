# tractian_challenge

A new Flutter project.

## Versões Necessárias

- **Dart**: ![Dart Version](https://img.shields.io/static/v1?label=Dart&amp;message=3.5.3&amp;color=blue&amp;logo=dart)
  [Documentação Oficial do Dart](https://dart.dev)

- **Flutter**: ![Flutter Version](https://img.shields.io/static/v1?label=Flutter&amp;message=3.24.3&amp;color=blue&amp;logo=flutter)
  [Documentação Oficial do Flutter](https://docs.flutter.dev/get-started/install)



## Como executar o projeto

- Certifique-se de que sua versão do dart seja >= 3.5.1

- Certifique-se de que sua versão do flutter seja >= 3.24.1

- Para executar o seu projeto você deve clonar o projeto que você acabou de fazer o fork

```ssh
https://github.com/thiago1cruz/tractian_challenge.git
```
- Acesse a pasta do projeto

```sh
cd tractian_challenge/
```

### Disclaimer

**Nota:** Certifique-se de que você tenha o Flutter instalado na versão apropriada antes de executar o projeto. Se for a sua primeira vez executando este projeto, será necessário baixar as dependências listadas no `pubspec.yaml`. Para isso, execute o seguinte comando no terminal:

```sh
flutter pub get
```

### 1. Visual Studio Code

#### Como Executar

- **Modo Debug (DEV portais)**:
  1. Abra o VS Code.
  2. Pressione `F5` ou vá em `Run > Start Debugging`.
  3. A execução será iniciada com o arquivo `lib/main.dart`.

### 2. Terminal

#### Como Executar

- **Modo Debug (DEV portais)**:
  1. Abra o terminal na raiz do projeto.
  2. Execute o seguinte comando:
     ```sh
     flutter run -t lib/main.dart
     ```


# Instruçoes de Envio

**Link do Video**: [Assistir ao vídeo](./assets/video/tractian_challenge.mp4)


**Potons de Melhoria**: 
1. Implementação dos testes de unidade, integração e alguns de UI.
2. Otimização dos controllers do módulo Assets.
3. Melhoria dos filtros, com a realização de POCs (provas de conceito) para identificar os cenários mais performáticos e, assim, obter filtros mais otimizados.
4. Algumas melhorias na UI.


**Disclaimer**:
O gerenciamento de estado abordado neste projeto foi o nativo `ChangeNotifier`, por entender que é uma solução simples para gerenciamento e por não querer adicionar outra biblioteca visando um pouco mais de desempenho. Também foi utilizado o padrão `State` junto.