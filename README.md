# GymBookerUPV - Script para reservar el gimnasio de la UPV

**Creado por Darío Pérez (aka M0B)**

Este script de bash te permite automatizar la reserva del gimnasio en la UPV. Simplemente sigue las instrucciones a continuación para comenzar a utilizarlo.

## Clonación del Repositorio

Para obtener este script y los archivos necesarios, puedes clonar este repositorio utilizando el siguiente comando `git clone` en tu terminal:

```bash
git clone https://github.com/ImM0B/GymBookerUPV.git
```

## Requisitos Previos

Antes de usar este script, asegúrate de tener los siguientes requisitos:

- **bash**: Asegúrate de tener `bash` instalado en tu sistema.

- **Permisos de Ejecución**: Dale permisos de ejecución al script `multiGymBooker.sh` utilizando el siguiente comando:

   ```bash
   chmod +x multiGymBooker.sh
   ```

- **Archivos de Configuración**: Los siguientes archivos deben estar presentes en el mismo directorio que el script:

  - `credentials.txt`: Archivo que contiene tus credenciales de acceso a la intranet de la UPV. Debe seguir el formato:

    ```
    Alias : DNI(solo números) : Contraseña 
    ```

  - `groups.txt`: Archivo que contiene los números de grupo que deseas reservar (Máximo 6 por cuenta). Los números tienen que ser de dos dígitos siempre, siguiendo el siguiente formato:

    ```
    NúmeroGrupo1 NúmeroGrupo2 NúmeroGrupo3 ...
    ```

  - `horarios`: Archivo con una tabla de horarios asignados a cada número de grupo.

## Ejecución

Para utilizar el script, sigue estos pasos:

1. Clona o descarga este repositorio en tu máquina local.

2. Asegúrate de que los archivos `credentials.txt` y `groups.txt` estén en el mismo directorio que el script.

3. Ejecuta el script `multiGymBooker.sh` con el siguiente comando:

   ```bash
   ./multiGymBooker.sh
   ```

   El script verificará las credenciales de acceso y esperará hasta que sea sábado a las 10:01 a.m. para realizar las reservas.

4. Una vez que sea el sábado a las 10:01 a.m. , el script procederá a realizar las reservas para cada conjunto de credenciales y grupos definidos en los archivos `credentials.txt` y `groups.txt`.

## Añadir Más Cuentas

Puedes añadir más cuentas de la intranet de la UPV al archivo `credentials.txt`. Cada cuenta debe estar asignada a una línea del archivo `groups.txt`. El script procesará todas las cuentas en secuencia del archivo `credentials.txt` y realizará las reservas para cada línea correspondiente del archivo `groups.txt`. Por ejemplo, para la línea 3 de `credentials.txt` se harán las reservas de la línea 3 de `groups.txt`.

## Ejecución en Segundo Plano

Para ejecutar el script en segundo plano y guardar el output en un archivo de registro (`log.txt`), puedes utilizar el siguiente comando:

   ```bash
   ./multiGymBooker.sh > log.txt 2>&1 &
   ```

Además, para desvincular el proceso del terminal actual y evitar que se detenga cuando cierras la terminal, puedes usar el comando `disown` después de ejecutar el script:

   ```bash
   disown
   ````

Esto permite que el script continúe ejecutándose incluso después de cerrar la terminal.  Si deseas mantener el script en ejecución en tu máquina sin apagarla puedes usar Google Cloud por ejemplo.

## Horarios

Aquí se muestra una tabla de horarios asignados a cada número de grupo:

```
·-----------------------------------------------------------------·
| Horario         | Lunes | Martes | Miércoles | Jueves | Viernes |
|-----------------|-------|--------|-----------|--------|---------|
| 07:30-08:30     |  01   |   15   |   29      |   43   |   57    |
| 08:30-09:30     |  02   |   16   |   30      |   44   |   58    |
| 09:30-10:30     |  03   |   17   |   31      |   45   |   59    |
| 11:30-12:30     |  04   |   18   |   32      |   46   |   60    |
| 12:30-13:30     |  05   |   19   |   33      |   47   |   61    |
| 13:30-14:30     |  06   |   20   |   34      |   48   |   62    |
| 14:30-15:30     |  07   |   21   |   35      |   49   |   63    |
| 15:30-16:30     |  08   |   22   |   36      |   50   |   64    |
| 16:30-17:30     |  09   |   23   |   37      |   51   |   65    |
| 17:30-18:30     |  10   |   24   |   38      |   52   |   66    |
| 18:30-19:30     |  11   |   25   |   39      |   53   |   67    |
| 19:30-20:30     |  12   |   26   |   40      |   54   |   68    |
| 20:30-21:30     |  13   |   27   |   41      |   55   |   69    |
| 21:30-22:30     |  14   |   28   |   42      |   56   |   70    |
·-----------------------------------------------------------------·
```
