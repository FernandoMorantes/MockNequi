# Sistema bancario - MockNequi

Prototipo basado en el servicio creado por Bancolombia para transferir dinero entre personas, cuyo nombre será Mock Nequi.

## Instalación

### Instrucciones Generales

#### Descarga

```bash
$ git clone https://github.com/btd1337/eOS-Sierra-Gt ~/Documentos
```

#### Dependencia de gemas

- Se necesitara instalar la gema bundler, se instala con el siguiente comando:

```bash
$ gem install bundler
```

- Al tener instalda esta gema dirigise a la carpeta de la aplicacion y ejecutar el siguiente comando:

```bash
$ bundle install
```

- Para mayor comodidad ejecutar el archivo `gem_install.rb` que se encuentra en la carpeta raiz de la aplicacion.

#### Dependencia MySQL

Para la ejecución de la aplicación es necesario instalar [XAMMP](https://www.apachefriends.org/es/index.html) donde estara la base de datos.

Enlaces de descarga:

- [XAMPP para linux](https://downloadsapachefriends.global.ssl.fastly.net/7.2.12/xampp-linux-x64-7.2.12-0-installer.run?from_af=true)
- [XAMPP para Windows](https://downloadsapachefriends.global.ssl.fastly.net/7.2.12/xampp-win32-7.2.12-0-VC15-installer.exe?from_af=true)
- [XAMPP para Mac](https://downloadsapachefriends.global.ssl.fastly.net/7.2.12/xampp-osx-7.2.12-0-vm.dmg?from_af=true)

Una vez instalado correr el sevidor de MySQL

## Uso

Entrar en la carpeta raiz de la aplicacion y ejecutar el siguiente comando:

```bash
$ ruby main.rb
```