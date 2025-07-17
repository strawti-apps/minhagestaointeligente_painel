# 🚀 Guia de Boas Práticas Flutter - Padrão Strawtter

> **Contexto para IA**: Este documento define os padrões arquiteturais e de desenvolvimento para criação de projetos Flutter seguindo as práticas consolidadas do Strawtter App.

## 🎯 Arquitetura Core

### Stack Tecnológica
- **Flutter + Dart**: Framework principal
- **GetX**: Gerenciamento de estado, rotas e dependências
- **Supabase**: Backend-as-a-Service
- **StrautiUtils**: Biblioteca de utilitários e tratamento de erros
- **Firebase**: Analytics e crash reporting

### Estrutura de Pastas (OBRIGATÓRIA)
```
lib/
├── main_dev.dart                    # Entrada desenvolvimento
├── main_prod.dart                   # Entrada produção
├── app_widget.dart                  # Widget raiz da aplicação
├── app_routes.dart                  # Centralizador de rotas
├── app_controller.dart              # Controller global
├── modules/                         # Features da aplicação
│   └── [feature_name]/
│       ├── [feature]_controller.dart
│       ├── [feature]_page.dart
│       ├── [feature]_routes.dart
│       └── widgets/
├── infra/                           # Camada de infraestrutura
│   ├── models/
│   │   ├── [model]_model.dart
│   │   └── defaults/
│   │       ├── response_model.dart
│   │       └── pagination_model.dart
│   ├── repositories/
│   │   └── [repository]_repository.dart
│   ├── services/
│   │   └── [service]_service.dart
│   └── helpers/
│       └── [helper]_helper.dart
├── shared/                          # Código compartilhado
│   ├── controllers/
│   ├── extensions/
│   ├── middlewares/
│   ├── mixins/
│   ├── themes/
│   └── utils/
└── widgets/                         # Widgets reutilizáveis
    ├── design_system/
    ├── data/
    ├── others/
    └── states/
```

## 📋 Padrões de Nomenclatura (CRÍTICO)

### Arquivos e Classes
```dart
// Controllers
class HomeController extends GetxController with LoaderManagerMixin

// Pages  
class HomePage extends StatelessWidget

// Models
class BannerModel

// Repositories
class BannersRepository extends StrautilsTryThis

// Widgets
class BannerCarouselWidget extends StatelessWidget

// Routes
final homeRoutes = [...]
```

### Convenções de Código
- **Variáveis**: `camelCase` → `mainCategories`, `isLoading`
- **Métodos privados**: `_nameMethod_` → `_fetchData()`, `_startAutoScroll()`
- **Constantes de rota**: `static const route = '/home'`
- **Arquivos**: `snake_case` → `home_controller.dart`, `banner_model.dart`

## 📊 TEMPLATE: Models (OBRIGATÓRIO)

```dart
import 'dart:convert';

class ExampleModel {
  final int id;
  final String name;
  final DateTime? createdAt;

  ExampleModel({
    required this.id,
    required this.name,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': criadoEm?.toIso8601String(),
    };
  }

  factory ExampleModel.fromMap(Map<String, dynamic> map) {
    return ExampleModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExampleModel.fromJson(String source) =>
      ExampleModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
```

### Regras dos Models
- ✅ SEMPRE usar `final` para propriedades
- ✅ SEMPRE implementar `toMap()`, `fromMap()`, `toJson()`, `fromJson()`
- ✅ SEMPRE usar valores padrão seguros (`?.toInt() ?? 0`)
- ✅ SEMPRE validar dados na criação

## 🗄️ TEMPLATE: Repositórios (OBRIGATÓRIO)

```dart
import 'package:strawti_utils/strawti_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExampleRepository extends StrautilsTryThis {
  final _client = Supabase.instance.client.from('table');

  FStrautilsResponse<List<ExampleModel>> buscarTodos() {
    return tryThis(() async {
      final result = await _client.select().order('id', ascending: true);

      return StrautilsResponse.success(
        List.from(result.map((map) => ExampleModel.fromMap(map))),
      );
    }, action: 'buscar todos os exemplos.');
  }

  FStrautilsResponse<ExampleModel?> buscarPorId(int id) {
    return tryThis(() async {
      final result = await _client.select().eq('id', id).maybeSingle();

      if (result == null) {
        return StrautilsResponse.success(null);
      }

      return StrautilsResponse.success(ExampleModel.fromMap(result));
    }, action: 'buscar exemplo por ID.');
  }
}
```

### Regras dos Repositórios
- ✅ SEMPRE herdar de `StrautilsTryThis`
- ✅ SEMPRE usar `tryThis()` para operações
- ✅ SEMPRE retornar `FStrautilsResponse<T>`
- ✅ SEMPRE usar ações descritivas no `tryThis()`
- ✅ SEMPRE implementar ordenação padrão

## 🎮 TEMPLATE: Controllers (OBRIGATÓRIO)

```dart
import 'package:get/get.dart';
import '../../shared/mixins/loader_manager.dart';
import '../../shared/utils/app_snackbar.dart';

class ExampleController extends GetxController with LoaderManagerMixin {
  final ExampleRepository _repository;

  ExampleController(this._repository);

  List<ExampleModel> itens = [];

  @override
  void onReady() {
    super.onReady();
    _loadData();
  }

  void _loadData() async {
    changeLoading(true);

    final response = await _repository.buscarTodos();
    if (!response.success) {
      AppSnackbar.to.show(response.message);
    } else {
      itens = response.data ?? [];
    }

    changeLoading(false);
  }

  // ❌ ERRADO - Loading duplicado
  void _metodoCompletoErrado() async {
    changeLoading(true); // ❌ Duplicado
    await _atualizarItem();
    await _criarItem();
    changeLoading(false); // ❌ Duplicado
  }

  // ✅ CORRETO - Loading só no método principal
  void _metodoCompletoCorreto() async {
    changeLoading(true);
    await _atualizarItemSemLoading();
    await _criarItemSemLoading();
    changeLoading(false);
  }

  Future<void> _atualizarItemSemLoading() async {
    final response = await _repository.atualizar();
    if (!response.success) {
      AppSnackbar.to.show(response.message);
    }
  }
}
```

### Regras dos Controllers
- ✅ SEMPRE usar `LoaderManagerMixin`
- ✅ SEMPRE injetar dependências via construtor
- ✅ SEMPRE implementar `onInit()`, `onReady()`, `onClose()` QUANDO PRECISAR DELES, SE NÃO PRECISAR NÃO IMPLEMENTAR
- ✅ SEMPRE usar métodos privados para operações internas
- ✅ SEMPRE usar `changeLoading()` em operações assíncronas
- ✅ SEMPRE tratar erros com `AppSnackbar` EXTRAIDO
- ✅ EVITAR `changeLoading()` aninhado (só no método principal)

## 📱 TEMPLATE: Pages (OBRIGATÓRIO)

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  static const route = '/example_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ExampleController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

### Regras das Pages
- ✅ SEMPRE definir `static const route`
- ✅ SEMPRE usar `GetBuilder` para escutar controller
- ✅ SEMPRE implementar loading state específico
- ✅ SEMPRE usar `SafeArea`
- ✅ SEMPRE usar `Scaffold` como base

### Exemplo de Loading Específico na UI
```dart
// ✅ CORRETO - Botões com loading independente
Row(
  children: [
    AppButtonDefault(
      text: 'Criar',
      onTap: controller.criarItem,
      isLoading: controller.isLoadingCreate, // Loading específico
    ),
    AppButtonDefault(
      text: 'Excluir',
      onTap: controller.excluirItem,
      isLoading: controller.isLoadingDelete, // Loading específico
    ),
  ],
)

// ❌ ERRADO - Mesmo loading para ambos
Row(
  children: [
    AppButtonDefault(
      text: 'Criar',
      onTap: controller.criarItem,
      isLoading: controller.isLoading, // ❌ Loading global
    ),
    AppButtonDefault(
      text: 'Excluir',
      onTap: controller.excluirItem,
      isLoading: controller.isLoading, // ❌ Loading global
    ),
  ],
)
```

## 🛣️ TEMPLATE: Rotas (OBRIGATÓRIO)

```dart
import 'package:get/get.dart';

// Arquivo: exemplo_routes.dart
final exampleRoutes = [
  GetPage(
    name: ExamplePage.route,
    page: () => const ExamplePage(),
    bindings: [
      BindingsBuilder.put(ExemploRepository.new),
      BindingsBuilder.put(() => ExampleController(Get.find())),
    ],
    middlewares: [AuthMiddleware()], // Se necessário
  ),
];

// Arquivo: app_routes.dart
class AppRoutes {
  AppRoutes._();

  static List<GetPage> pages = [
    GetPage(name: SplashPage.route, page: () => const SplashPage()),
    ...authRoutes,
    ...homeRoutes,
    ...exampleRoutes,
  ];
}
```

### Regras das Rotas
- ✅ SEMPRE agrupar rotas por módulo
- ✅ SEMPRE usar `BindingsBuilder.put()`
- ✅ SEMPRE injetar repositórios antes dos controllers
- ✅ SEMPRE usar middlewares quando necessário

## 🧩 TEMPLATE: Widgets Customizados
### Regras dos widgets
- ✅ SEMPRE extrair com classes StatelessWidget
- ✅ SE FOR PEDIR VÁRIOS PARAMETROS QUE JÁ TEM NUM MODEL, PEÇA O MODEL INTEIRO
- ✅ SE JÁ TEM UM GETBUILDER NA ARVORE DE WIDGETS ACIMA, SÓ PASSAR A INSTANCIA DO CONTROLLER POR PARAMETROS E NÃO FICAR COLOCANDO VÁRIOS GETBUILDERS NOS WIDGETS EXTRAIDOS ARVORE ABAIXO

```dart
class ExampleWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isLoading;

  const ExampleWidget({
    super.key,
    required this.title,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
```

## 🎨 Design System Obrigatório

### Estrutura Base
```
widgets/design_system/
├── app_button_default.dart    # Botão padrão
├── app_text_form_field.dart   # Campo de texto
├── text_default.dart          # Texto padrão
└── app_card_widget.dart       # Card padrão
```

### Componentes Essenciais
```dart
// AppSnackbar - SEMPRE usar para feedback
class AppSnackbar {
  AppSnackbar._();
  
  static AppSnackbar get to => AppSnackbar._();
  
  void show(String message, {Widget? mainButton}) {
    Get.rawSnackbar(
      message: message,
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(10),
      borderRadius: 8.0,
      snackPosition: SnackPosition.BOTTOM,
      mainButton: mainButton ?? TextButton(
        onPressed: Get.back,
        child: const Text('OK', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
```

## ⚠️ Tratamento de Erros (CRÍTICO)

### Padrão Obrigatório
```dart
// No Repository
FStrautilsResponse<T> operacao() {
  return tryThis(() async {
    return StrautilsResponse.success(resultado);
  }, action: 'descrição da operação');
}

// No Controller
final response = await _repository.operacao();
if (!response.success) {
  AppSnackbar.to.show(response.message);
} else {
  dados = response.data ?? [];
}
```

## 🛡️ Middleware de Autenticação

```dart
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (UserHelper.instance.authId.isEmpty) {
      Future.delayed(const Duration(seconds: 1)).whenComplete(() {
        AppSnackbar.to.show("Sessão expirada! Entre novamente");
      });
      return const RouteSettings(name: LoginPage.route);
    }
    return null;
  }
}
```

## 🚀 Fluxo de Desenvolvimento (OBRIGATÓRIO)

### 1. Criação de Feature
```bash
modules/nova_feature/
├── nova_feature_controller.dart
├── nova_feature_page.dart
├── nova_feature_routes.dart
└── widgets/
    └── componentes_especificos.dart
```

### 2. Sequência de Implementação
1. **Model** → Criar com validações e conversões
2. **Repository** → Implementar com `StrautilsTryThis`
3. **Controller** → Usar `LoaderManagerMixin`
4. **Page** → Usar `Scaffold` e `GetBuilder`
5. **Routes** → Configurar dependências
6. **Widgets** → Quebrar em componentes reutilizáveis

### 3. Regras de Loading

#### A) Loading Global vs Específico
```dart
// ✅ CORRETO - Loading específico por ação
void _criarItem() async {
  changeLoadingCreate(true);
  final response = await _repository.criar();
  if (!response.success) {
    AppSnackbar.to.show(response.message);
  }
  changeLoadingCreate(false);
}

void _excluirItem() async {
  changeLoadingDelete(true);
  final response = await _repository.excluir();
  if (!response.success) {
    AppSnackbar.to.show(response.message);
  }
  changeLoadingDelete(false);
}

// ❌ ERRADO - Loading global para ações específicas
void _criarItemErrado() async {
  changeLoading(true); // ❌ Bloqueia toda a tela
  await _repository.criar();
  changeLoading(false);
}
```

#### B) Loading Aninhado
```dart
// ✅ CORRETO - Um método principal controla o loading
void _operacaoCompleta() async {
  changeLoading(true);
  await _metodo1SemLoading();
  await _metodo2SemLoading();
  changeLoading(false);
}

// ❌ ERRADO - Loading duplicado/aninhado
void _operacaoErrada() async {
  changeLoading(true);
  await _metodo1ComLoading(); // ❌ Já tem loading interno
  await _metodo2ComLoading(); // ❌ Já tem loading interno
  changeLoading(false);
}
```

### 4. Checklist Obrigatório
- [ ] Model com `toMap()`, `fromMap()`, `toJson()`, `fromJson()`
- [ ] Repository com `tryThis()` e `FStrautilsResponse`
- [ ] Controller com `LoaderManagerMixin`
- [ ] Page com `Scaffold`, `GetBuilder` e loading state
- [ ] Routes com `BindingsBuilder.put()`
- [ ] Tratamento de erros com `AppSnackbar`
- [ ] Middlewares configurados se necessário

## 🎯 Dependências Essenciais

### pubspec.yaml Base
```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6
  supabase_flutter: ^2.8.2
  strawti_utils:
    git:
      url: https://github.com/strawti-apps/strautils.git
  firebase_core: ^3.12.1
  firebase_crashlytics: ^4.2.0
```

## 📝 Mixins Obrigatórios

### LoaderManagerMixin
```dart
mixin LoaderManagerMixin on GetxController {
  bool isLoading = false;
  bool isLoadingCreate = false;
  bool isLoadingDelete = false;
  bool isLoadingUpdate = false;

  void changeLoading(bool loading) {
    isLoading = loading;
    update();
  }

  void changeLoadingCreate(bool loading) {
    isLoadingCreate = loading;
    update();
  }

  void changeLoadingDelete(bool loading) {
    isLoadingDelete = loading;
    update();
  }

  void changeLoadingUpdate(bool loading) {
    isLoadingUpdate = loading;
    update();
  }
}
```

## 🎨 Temas Obrigatórios

### AppColors
```dart
class AppColors {
  static const primaryBlue = Color(0xFF007AFF);
  static const white = Color(0xFFFFFFFF);
  static const textBlack = Color(0xFF000000);
  static const primaryGrey = Color(0xFF8E8E93);
}
```

---

## 🔥 REGRAS CRÍTICAS PARA IA

### SEMPRE Implementar:
1. **Models**: `toMap()`, `fromMap()`, `toJson()`, `fromJson()`
2. **Repositories**: Herdar `StrautilsTryThis`, usar `tryThis()`
3. **Controllers**: `LoaderManagerMixin`, `onInit()`, `onReady()`, `onClose()`
4. **Pages**: `Scaffold`, `GetBuilder`, loading state, `SafeArea`
5. **Routes**: `BindingsBuilder.put()`, injeção de dependências
6. **Errors**: `AppSnackbar` para feedback

### NUNCA Fazer:
1. ❌ Controller sem `LoaderManagerMixin`
2. ❌ Repository sem `StrautilsTryThis`
3. ❌ Page sem `GetBuilder` e loading state
4. ❌ Model sem conversões toMap e fromMap
5. ❌ Operação assíncrona sem tratamento de erro
6. ❌ Loading sem `changeLoading()`
7. ❌ Comentários desnecessários (só em controllers complexos)
8. ❌ `changeLoading()` aninhado/duplicado em métodos
9. ❌ Loading global para ações específicas (usar loading específico)

### Recomendações extras
### ✅ Simplicidade sempre é o melhor caminho
Evite complexidade desnecessária. Soluções simples são mais fáceis de entender, manter e escalar.

---

### ✅ Sempre que possível resolva as coisas com parâmetros dos widgets
Configure widgets diretamente por parâmetros ao invés de lógica adicional. Isso mantém o código mais limpo.

---

### ✅ Sempre que possível deixe que o Flutter resolva as coisas para você
Use widgets e comportamentos nativos antes de criar soluções customizadas.  
Exemplos: `LayoutBuilder`, `MediaQuery`, etc.

---

### ✅ Sempre tente não colocar lógica e objetos soltos na view ou dentro do método `build`
Evite lógica dentro do `build`. Extraia para **controllers**, **services** ou use **State Management** adequado.

---

### ✅ Sempre use uma mente de POE (Programação Orientada a Extração)
Divida responsabilidades. Extraia widgets, classes e métodos.  
Isso torna o código mais **modular** e **reutilizável**.

---

### ✅ Sempre tente deixar as coisas previsíveis e padronizadas
Evite surpresas. Mantenha **consistência** no estilo, nomenclatura e estrutura do projeto.

---

### ✅ Sempre use widgets extraídos como classes `StatelessWidget` e `StatefulWidget` ao invés de métodos que retornam `Widget`
Classes oferecem mais **controle**, **legibilidade** e **escalabilidade** que métodos simples.

---

### ✅ Widgets extraídos sempre dentro do seu próprio arquivo
Todo widget extraído deve estar em um arquivo separado dentro da pasta `widgets/` correspondente ao módulo ou submódulo.

---

### ✅ Sempre tipe os objetos, classes e retornos de métodos
Evita erros, melhora a legibilidade e ativa o **auto-complete** durante o desenvolvimento.

---

### ✅ Sempre use vírgula no final dos widgets
Facilita **reordenação** e **formatação automática** com o Flutter Formatter.

---

### ✅ Sempre que possível use `models`
Utilize models para representar dados e facilitar:
- Tipagem
- Validação
- Conversão (ex: `JSON <-> Dart`)

---

### ✅ Sempre buscar fazer as coisas seguindo as versões mais recentes do Flutter
Mantenha o projeto atualizado para aproveitar:
- Melhorias de performance
- Segurança
- Novas funcionalidades

---

### ✅ Seguir a estrutura e estilo do projeto atual
Mantenha **consistência** com o código existente:
- Nomes de pastas
- Padrão de arquitetura
- Nomenclaturas

---

### ✅ Priorizar o uso de `GetBuilder` ao invés de `Obx` para mudança de estado
Use `Obx` apenas quando **realmente necessário**.  
`GetBuilder` com nome do controller é mais **legível** e **eficiente** em performance.

---

### ✅ Sempre que for usar `.withValues(alpha:)`, prefira `.withAlpha(value)`
`withOpacity` está **depreciado** em versões mais recentes do Flutter.

---

### ❌ Nunca desmonte, remova ou estrague algo que já está funcionando e não tem relação com a missão passada para você
Sempre verifique se **realmente** precisa alterar algo para cumprir sua tarefa.

---

### ✅ Sempre priorize usar `ternaryClean()` ao invés de ternários na view
Método que deixa os ternários mais **limpos** e **bonitos** na view.

---

### ✅ Sempre use `debugPrint()` ao invés de `print()`
Mais eficiente e evita limitações de buffer.

*Este é o padrão Strawtter - seguir rigorosamente para manter consistência.* 