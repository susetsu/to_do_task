<p align="center">
  <a href="https://docs.docker.com/" target="blank"><img src="https://storage.googleapis.com/cms-storage-bucket/6a07d8a62f4308d2b854.svg" width="330" alt="Flutter Logo" /></a>
</p>

 * **Contents**
	- [Overview](#overview)
	- [Development environment](#development-environment)
	- [Android Debug](#android-debug)
	- [Android Release](#android-release)
	- [iOS Debug](#ios-debug)	
	- [iOS Release](#ios-release)
	- [Configuraciones](#configuraciones)
	- [Actualizar paquetes obsoletos](#actualizar-paquetes-obsoletos)
	- [Librerias utilizadas](#librerias-utilizadas)
	- [Instalaciones recomendadas](#instalaciones-recomendadas)
	- [Extensiones de VSCode recomendadas para el desarrollo de Flutter](#extensiones-de-vscode-recomendadas-para-el-desarrollo-de-flutter)
	


## Overview

Aplicacion de muestra de lista de Tareas con BloC.

> En este repositorio  se mantiene la aplicación [Flutter](https://flutter.dev//) que permite empaquetar para plataformas Android y iOS.


## Requirements

  * [git](https://git-scm.com/) versión **2.x** o superior

# install dependencies
flutter packages get
```

> El contenedor le ayudará a interactuar con la herramienta de linea de comando de Cordova, para mayor información sobre flutter visitar:
>
> [flutter-cli reference](https://docs.flutter.dev/reference/flutter-cli)

## Android Debug
 
En caso de querer ejecutar el app desde android studio primero debe preparar el app para tal plataforma usando la siguiente línea de comando:

```bash
# build del app android, run at least the first time
 flutter build apk --debug
```

> Para mayor información visitar:
>
> * [Debugging Flutter apps](https://docs.flutter.dev/testing/debugging)

## Android Release

```bash
# android release build
flutter build apk --release
```

> Para mayor información visitar
>
> * [android app signing](https://developer.android.com/studio/publish/app-signing)
> * [Build and release an Android app](https://docs.flutter.dev/deployment/android?gclid=CjwKCAjwrranBhAEEiwAzbhNtTeY_sa-D8JoC4HbPZ5Pw26V7S_CnL17vWqRm83cnZ6QyTHQrCg0kRoC7v4QAvD_BwE&gclsrc=aw.ds)


## iOS Debug

Para depurar una aplicación Flutter en iOS, puedes seguir estos pasos:

1. Asegúrate de tener [Xcode](https://developer.apple.com/xcode/) instalado en tu Mac. [Xcode](https://developer.apple.com/xcode/) es necesario para el desarrollo y depuración en iOS.
2. Abre tu proyecto [Flutter](https://flutter.dev/) en un editor de código o [IDE](https://es.wikipedia.org/wiki/Entorno_de_desarrollo_integrado).
3. Conecta tu dispositivo [iOS](https://es.wikipedia.org/wiki/IOS) a tu Mac utilizando un cable USB.
4. Abre Terminal o una línea de comandos y navega hasta el directorio raíz de tu proyecto Flutter.
5. Ejecuta el siguiente comando para iniciar la sesión de depuración:
```bash
flutter run --debug
```
> Este comando instalará la aplicación en tu dispositivo [iOS](https://es.wikipedia.org/wiki/IOS) conectado y la ejecutará en modo de depuración. Verás los registros e información de depuración en Terminal o la línea de comandos.

6. Si [Xcode](https://developer.apple.com/xcode/) te solicita que elijas un dispositivo para la depuración, selecciona tu dispositivo [iOS](https://es.wikipedia.org/wiki/IOS) conectado.
7. Ahora puedes establecer puntos de interrupción en tu código, inspeccionar variables y depurar tu aplicación Flutter utilizando las herramientas de depuración proporcionadas por [Xcode](https://developer.apple.com/xcode/).
8. Para recargar en caliente tu aplicación durante la depuración, presiona `r` en Terminal o la línea de comandos.
9. Si encuentras algún problema durante la depuración, asegúrate de que tu dispositivo [iOS](https://es.wikipedia.org/wiki/IOS) esté correctamente conectado y reconocido por Xcode. También verifica que tengas los permisos y certificados necesarios configurados para la depuración en tu dispositivo.

> Ten en cuenta que para la depuración en iOS, necesitarás una Mac, ya que Xcode solo está disponible en macOS. También es posible depurar en simuladores de iOS, pero ejecutar la aplicación en un dispositivo [iOS](https://es.wikipedia.org/wiki/IOS) físico proporciona una representación más precisa del comportamiento de la aplicación.

## iOS Release

Para empaquetar una aplicación Flutter en la plataforma iOS, puedes seguir estos pasos:

1. Abre tu proyecto [Flutter](https://flutter.dev/) en un editor de código o [IDE](https://es.wikipedia.org/wiki/Entorno_de_desarrollo_integrado).
2. Asegúrate de tener Xcode instalado en tu Mac, ya que necesitarás utilizar sus herramientas para empaquetar la aplicación.
3. Abre Terminal o una línea de comandos y navega hasta el directorio raíz de tu proyecto Flutter.
4. Ejecuta el siguiente comando para generar los archivos necesarios para iOS:
```bash
flutter build ios --release
```
> Este comando compilará tu aplicación en modo de lanzamiento y generará los archivos necesarios para iOS.

5. Una vez que el comando se complete, se generarán los archivos en la carpeta `build/ios` de tu proyecto.
6. Abre el archivo `Runner.xcworkspace` en Xcode. Puedes encontrar este archivo en la carpeta `ios` de tu proyecto.
7. En Xcode, selecciona tu dispositivo de destino (o elige "Generic [iOS](https://es.wikipedia.org/wiki/IOS) Device" para generar un archivo de aplicación genérico).
8. Haz clic en el menú `Product` y elige `Archive`. Esto creará un archivo de aplicación para iOS.
9. Después de completar el proceso de archivado, Xcode abrirá la ventana de `Organizator` que muestra los archivos de aplicación archivados.
10. Desde la ventana de `Organizator`, puedes seleccionar el archivo de aplicación archivado y hacer clic en `Distribute App` para exportar el archivo de aplicación en el formato deseado, como un archivo `.ipa` para distribución en la App Store.

> Una vez que hayas seguido estos pasos , tendrás un archivo de aplicación empaquetado y listo para ser distribuido en la plataforma iOS.

Si desea ejecutar en un dispositivo fisico iOS y que el dispositivo pueda correr la aplicacion desde home puede usar: 

```bash
flutter run --release
```

# Configuraciones

Para generar un archivo aab, debe colocar la ruta del archivo ``` jks``` encontrado en la carpeta ```keystore``` en la raíz del proyecto en el archivo key.properties encontrado en la carpeta ``` android```  y luego ejecutar
```
flutter build appbundle
```
Para cambiar la versión de la aplicación
* Debe ir al archivo ```pubspec.yaml``` y cambiar el valor de ```version``` al deseado. Ejemplo: ```version: 1.0.2+3```


* Para agregar un schema a la base de datos isar

  - Agregar el decorador @collection en la entidad (modelo) deseada
  - Importar la libreria en la enitdad (modelo) ```<mi-archivo-entidad>.dart ```
  - Agregar ``` part '<nombre-clase-entidad>.g.dart' ```
  - Ejecutar: ``` dart run build_runner build ```
  - Para más información puede ver la documentación de [isar](https://isar.dev/es/tutorials/quickstart.html)


# Actualizar paquetes obsoletos
Para actualizar librerias obsoletas ejecute el siguiente comando: 
```flutter pub upgrade outdated_package ```
  

# Librerias utilizadas

* [animate_do - Animaciones](https://pub.dev/packages/animate_do)

* [intl - Proporciona funciones de internacionalización y localización, incluida la traducción de mensajes, plurales y géneros, formato y análisis de fecha/número y texto bidireccional.](https://pub.dev/packages/intl)

* [flutter_bloc - Widgets que facilitan la integración de bloques y codos en Flutter . Creados para funcionar con package:bloc.](https://pub.dev/packages/flutter_bloc)


* [flutter_form_builder - Este paquete ayuda a crear formularios de recopilación de datos en Flutter al eliminar el texto estándar necesario para crear un formulario, validar campos, reaccionar a los cambios y recopilar información final del usuario.](https://pub.dev/packages/flutter_form_builder)

* [fluttertoast - Libreria toast para Flutter.](https://pub.dev/packages/fluttertoast)

* [form_builder_validators - Form Builder Validators conjunto de validadores para cualquier FormFieldwidget o widgets que extiendan la FormFieldclase , por ejemplo , etc. Proporciona reglas de validación estándar listas para usar y una forma de componer nuevas reglas de validación combinando múltiples reglas, incluidas las personalizadas.TextFormFieldDropdownFormField.](https://pub.dev/packages/form_builder_validators)

* [go_router - Manejo de la navegación entre pantallas](https://pub.dev/packages/go_router)

* [logger - Registrador pequeño, fácil de usar y extensible que imprime hermosos registros. Inspirado en el registrador para Android.](https://pub.dev/packages/logger)


* [flutter_lints - Contiene un conjunto recomendado de lints para aplicaciones, paquetes y complementos de Flutter para fomentar buenas prácticas de codificación](https://pub.dev/packages/flutter_lints)


# Instalaciones recomendadas

Descargar las hojas de atajos recomendadas:

[Guías de atajos - Dart ](https://devtalles.com/files/dart-cheat-sheet.pdf)

[Guías de atajos - Flutter ](https://devtalles.com/files/flutter-cheat-sheet.pdf)

## Extensiones de VSCode recomendadas para el desarrollo de Flutter

* [Activitus Bar](https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.activitusbar)

* [Error Lens](https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens)

* [Paste JSON as Code](https://marketplace.visualstudio.com/items?itemName=quicktype.quicktype)

* [Better Comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments)

* [Terminal](https://marketplace.visualstudio.com/items?itemName=formulahendry.terminal)

* [Awesome Flutter Snippets](https://marketplace.visualstudio.com/items?itemName=Nash.awesome-flutter-snippets)

* [Bloc](https://marketplace.visualstudio.com/items?itemName=FelixAngelov.bloc)

* [Dart Language](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)

* [Flutter Support](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)

* [Pubspec Assist](https://marketplace.visualstudio.com/items?itemName=jeroen-meijer.pubspec-assist)

* [Lorem ipsum](https://marketplace.visualstudio.com/items?itemName=Tyriar.lorem-ipsum)

