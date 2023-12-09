# chq.to
## _Trabajo Final Integrador -  TTPS ‐ Ruby_

Esta aplicacion web permite acortar links de URLs, para luego poder utilizarlos en redes sociales o cualquier comunicación 
online para compartir páginas de manera sencilla. Se podran generar distintos tipos de links dependiendo de la utilidad que se tenga en mente: 
- Links regulares
- Links temporales con una fecha y hora de vencimiento
- Links privados con contraseña
- Links efimeros que permitiran un único acceso


## Requisitos

- Ruby 3.2.2
- Base de datos SQLite


## Instalación

- Clonar repositorio -> https://github.com/federicoherce/chq.to.git
- Ir al directorio de la aplicacion -> 'chq.to'
- Instala las gemas necesarias para utilizar la aplicación -> bundle install
- Crea la base de datos -> rails db:create
- Cargar la base de datos con datos de prueba -> rails db:seed


## Uso

- Dentro del directorio 'chq.to' ejecutar rails s / rails server
De esta manera, la aplicación estará corriendo en http://localhost:3000.


Usuario: fede@gmail.com
Contraseña: 1234

La aplicación utiliza la gema devise para facilitar la autenticación de usuarios, permitiendo crear, autenticar, editar y eliminar usuarios de manera sencilla.
Se utiliza STI (Single Table Inheritance) para la creación de links, especificando el tipo específico en el campo "type". Esto facilita la creacion y edición de 
links, sin tener que preguntar en el controlador por el tipo de link especifico que se esta manipulando.
Cada subclase de link implementa el metodo "redirect" de la forma correspondiente, dependiendo si se cumplen o no las condiciones para la redirección a la URL original.
El slug para cada link se genera a partir de su id, que se codificara a Base 64 una vez que el link es creado, y luego se decodificara cuando se acceda a la ruta del 
sitio + el slug
Cuando se confirma que la redirección es exitosa, se almacena en la base de datos información para generar estadisticas: Un modelo se encargara de contabilizar las
redirecciones totales por dia, y otro de almancear la fecha y dirección ip de cada acceso. Como se tratan de dos tipos de estadisticas distintas, una que suma los 
accesos totales por dia y otra que contabiliza cada acceso, se decidió hacer dos modelos distintos, y dos tablas en la base de datos independientes.

