# Course Project 1

Esta asignación utiliza datos del repositorio de aprendizaje automático de **UC Irvine**, un repositorio popular para conjuntos de datos de aprendizaje automático. En particular, utilizaremos el “Individual household electric power consumption Data Set” que he puesto a disposición en el sitio web del curso:

* **Conjunto de datos:** consumo de energía eléctrica [20Mb]

* **Descripción:** Mediciones del consumo de energía eléctrica en un hogar con una frecuencia de muestreo de un minuto durante un período de casi 4 años. Se encuentran disponibles diferentes cantidades eléctricas y algunos valores de submedición.

Las siguientes descripciones de las 9 variables en el conjunto de datos se toman del sitio web de UCI:

1. **Fecha**: Fecha en formato dd / mm / aaaa
2. **Hora**: hora en formato hh: mm: ss
3. **Global_active_power**: potencia activa global promedio de minutos del hogar (en kilovatios)
4. **Global_reactive_power**: potencia reactiva global promedio por minuto de los hogares (en kilovatios)
5. **Voltaje**: voltaje promedio por minuto (en voltios)
6. **Intensidad_global**: intensidad de corriente global promedio por minuto de los hogares (en amperios)
7. **Sub_metering_1**: submedición de energía No. 1 (en vatios-hora de energía activa). Corresponde a la cocina, que contiene principalmente un lavavajillas, un horno y un microondas (las placas eléctricas no son eléctricas, sino que funcionan con gas).
8. **Sub_metering_2**: submedición de energía No. 2 (en vatios-hora de energía activa). Corresponde al lavadero, que contiene una lavadora, una secadora, una nevera y una luz.
9. **Sub_metering_3**: submedición de energía No. 3 (en vatios-hora de energía activa). Corresponde a un calentador de agua eléctrico y un aire acondicionado.


## Criterios de revisión

1. ¿Se ha enviado una URL de GitHub válida que contenga un repositorio de git?
2. ¿El repositorio de GitHub contiene al menos una confirmación más allá de la bifurcación original?
3. Examine los archivos de trazado en el repositorio de GitHub. ¿Los archivos de la trama parecen tener el formato de archivo de gráficos correcto?
4. ¿Cada trama parece correcta?
5. ¿Cada conjunto de código R parece crear el gráfico de referencia?


## Revisión de las asignaciones

Tenga en cuenta que este curso trata sobre gráficos exploratorios, comprensión de los datos y desarrollo de estrategias. Aquí hay una buena cita de una lección de remolino sobre gráficos exploratorios: *"Nos ayudan a encontrar patrones en los datos y entender sus propiedades. Sugieren estrategias de modelado y ayudan a depurar análisis. NO utilizamos gráficos exploratorios para comunicar resultados".*

Las rúbricas siempre deben interpretarse en ese contexto.

Mientras realiza su evaluación, mantenga una mente abierta y concéntrese en lo positivo. El objetivo no es deducir puntos sobre pequeñas desviaciones de los requisitos o por diferencias legítimas en los estilos de implementación, etc. Busque maneras de dar puntos cuando está claro que el remitente ha hecho un esfuerzo de buena fe para hacer el proyecto, y cuando es probable que han tenido éxito Lo más importante, está bien si una persona hizo algo diferente de la forma en que lo hiciste. El punto no es ver si alguien logró igualar su forma de hacer las cosas, sino ver si alguien cumplió objetivamente la tarea en cuestión.

Para ello, tenga en cuenta lo siguiente:

**HACER**:

* Revisa el código fuente.
* Mantenga una mente abierta y concéntrese en lo positivo.
* En caso de duda, errar por dar demasiados puntos, en lugar de dar muy pocos.
* Pregúntese si una trama podría responder una pregunta para la persona que la creó.
* Recuerde que no todos tienen los mismos antecedentes y conocimientos estadísticos.

**NO HACER**:

* Deduzca solo porque no está de acuerdo con los métodos estadísticos de alguien.
* Deduzca solo porque no está de acuerdo con los métodos de trazado de alguien.
* Deducción basada en la estética.

## Cargando los datos

Al cargar el conjunto de datos en R, tenga en cuenta lo siguiente:

* El conjunto de datos tiene 2,075,259 filas y 9 columnas. Primero calcule una estimación aproximada de cuánta memoria requerirá el conjunto de datos en la memoria antes de leer en R. Asegúrese de que su computadora tenga suficiente memoria (la mayoría de las computadoras modernas deberían estar bien).

* Solo utilizaremos datos de las fechas 2007-02-01 y 2007-02-02. Una alternativa es leer los datos solo de esas fechas en lugar de leer todo el conjunto de datos y subconjunto a esas fechas.

* Puede resultarle útil convertir las variables de fecha y hora a clases de fecha/hora en R utilizando las funciones ``strptime()`` y ``as.Date ()``.

* Tenga en cuenta que en este conjunto de datos los valores faltantes se codifican como ?.


## Haciendo graficos

Nuestro objetivo general aquí es simplemente examinar cómo el uso de energía del hogar varía durante un período de 2 días en febrero de 2007. Su tarea es reconstruir los siguientes graficos a continuación, todas las cuales fueron construidas utilizando el sistema de trazado base.

Primero deberá bifurcar y clonar el siguiente repositorio de GitHub: https://github.com/rdpeng/ExData_Plotting1

Para cada parcela deberías

* Construya el diagrama y guárdelo en un archivo PNG con un ancho de 480 píxeles y una altura de 480 píxeles.

* Nombre cada uno de los archivos de trazado como **plot1.png**, **plot2.png**, etc.

* Cree un archivo de código R separado (**plot1.R, plot2.R**, etc.) que construye el correspondiente grafico, es decir, código en **plot1.R** construye el grafico **plot1.png**. Su archivo de código debe incluir código para leer los datos para que la trama se pueda reproducir completamente. También debe incluir el código que crea el archivo PNG.

* Agregue el archivo PNG y el archivo de código R a la carpeta de nivel superior de su repositorio git (sin necesidad de subcarpetas separadas)

* Cuando haya terminado con la tarea, empuje su repositorio de git a GitHub para que la versión de GitHub de su repositorio esté actualizada. Debe haber cuatro archivos PNG y cuatro archivos de código R, un total de ocho archivos en la carpeta de nivel superior del repositorio.

Los cuatro graficos que necesitará construir se muestran a continuación.

Grafico 1

![Grafico 1](https://github.com/jtellez93/Data-Science/blob/master/4-Exploratory%20Data%20Analysis/Project/week_1/ExDataCP1Plot1.png)

Grafico 2

![Grafico 2](https://github.com/jtellez93/Data-Science/blob/master/4-Exploratory%20Data%20Analysis/Project/week_1/ExDataCP1Plot2.png)

Grafico 3

![Grafico 3](https://github.com/jtellez93/Data-Science/blob/master/4-Exploratory%20Data%20Analysis/Project/week_1/ExDataCP1Plot3.png)

Grafico 4

![Grafico 4](https://github.com/jtellez93/Data-Science/blob/master/4-Exploratory%20Data%20Analysis/Project/week_1/ExDataCP1Plot4.png)







