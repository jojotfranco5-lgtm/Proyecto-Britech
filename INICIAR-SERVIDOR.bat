@echo off
setlocal EnableDelayedExpansion
REM ============================================================
REM  Britech - arranca el servidor de la app en el puerto 8123.
REM  Doble clic para prenderlo. Deja esta ventana ABIERTA
REM  mientras uses la app. Para apagarlo: cerra la ventana.
REM
REM  Detecta solo las versiones de PHP y MySQL instaladas en
REM  Laragon (C:\laragon). La primera vez ademas prepara todo:
REM    1. crea el .env (copia de .env.example) si no existe
REM    2. instala dependencias (composer install) si falta vendor\
REM    3. prende MySQL de Laragon si esta apagado
REM    4. crea la base britech_v2 (importa database\*.sql en orden)
REM  Si Laragon esta en otra carpeta, cambia LARAGON abajo.
REM ============================================================
cd /d "%~dp0"
set "LARAGON=C:\laragon"

REM ---------- PHP: primero 8.3, si no cualquier 8.x, si no el del PATH ----------
set "PHP="
for /d %%D in ("%LARAGON%\bin\php\php-8.3*") do if exist "%%D\php.exe" set "PHP=%%D\php.exe"
if not defined PHP for /d %%D in ("%LARAGON%\bin\php\php-8*") do if exist "%%D\php.exe" set "PHP=%%D\php.exe"
if not defined PHP for %%P in (php.exe) do if not "%%~$PATH:P"=="" set "PHP=%%~$PATH:P"
if not defined PHP (
    echo   [ERROR] No encontre PHP. Instala Laragon en %LARAGON% o agrega php al PATH.
    pause & exit /b 1
)

REM ---------- MySQL de Laragon ----------
set "MYSQLBIN="
for /d %%D in ("%LARAGON%\bin\mysql\mysql-*") do if exist "%%D\bin\mysql.exe" set "MYSQLBIN=%%D\bin"
if not defined MYSQLBIN (
    echo   [ERROR] No encontre MySQL en %LARAGON%\bin\mysql.
    pause & exit /b 1
)

echo.
echo   PHP:   %PHP%
echo   MySQL: %MYSQLBIN%
echo.

REM ---------- 1. .env ----------
if not exist ".env" (
    echo   Creando .env a partir de .env.example...
    copy /y ".env.example" ".env" >nul
)

REM ---------- 2. Dependencias (composer) ----------
if not exist "vendor\autoload.php" (
    echo   Instalando dependencias con composer ^(solo la primera vez^)...
    if exist "%LARAGON%\bin\composer\composer.phar" (
        "%PHP%" "%LARAGON%\bin\composer\composer.phar" install --no-interaction
    ) else (
        call composer install --no-interaction
    )
    if not exist "vendor\autoload.php" (
        echo   [ERROR] Fallo composer install. Revisa la conexion a internet.
        pause & exit /b 1
    )
)

REM ---------- 3. MySQL prendido ----------
"%MYSQLBIN%\mysqladmin.exe" -u root --silent ping >nul 2>&1
if not errorlevel 1 goto mysql_ok
echo   Prendiendo MySQL de Laragon...
start "MySQL (Britech)" /min "%MYSQLBIN%\mysqld.exe" --defaults-file="%MYSQLBIN%\..\my.ini" --standalone
set /a INTENTOS=0
:esperar_mysql
"%SystemRoot%System32	imeout.exe" /t 2 /nobreak >nul
"%MYSQLBIN%\mysqladmin.exe" -u root --silent ping >nul 2>&1
if not errorlevel 1 goto mysql_ok
set /a INTENTOS+=1
if %INTENTOS% lss 15 goto esperar_mysql
echo   [ERROR] MySQL no arranco. Abri Laragon y toca "Start All".
pause & exit /b 1
:mysql_ok

REM ---------- 4. Base de datos (la que diga DB_NAME en el .env) ----------
set "MYSQL="%MYSQLBIN%\mysql.exe" -u root --default-character-set=utf8mb4"
set "DBNAME=britech_v2"
for /f "usebackq tokens=1,* delims==" %%A in (".env") do if /i "%%A"=="DB_NAME" set "DBNAME=%%B"
echo   Base de datos: %DBNAME%
%MYSQL% -e "USE %DBNAME%" >nul 2>&1
if not errorlevel 1 goto base_existe
REM Los schemas del repo crean SIEMPRE britech_v2: si el .env apunta a otra base
REM (ej. un volcado importado a mano), no se puede crear sola.
if /i not "%DBNAME%"=="britech_v2" (
    echo   [ERROR] La base %DBNAME% ^(DB_NAME del .env^) no existe.
    echo   Importa tu volcado .sql en esa base, o pone DB_NAME=britech_v2 para crearla desde los schemas.
    pause & exit /b 1
)
(
    echo   Creando la base britech_v2 ^(solo la primera vez^)...
    %MYSQL% < "database\schema_ventas.sql" || goto error_sql
    REM Mismo orden que el README (las FK dependen de el).
    for %%F in (auth datos_maestros min_mayorista imagenes tienda pagos envios envios_datos favoritos mayorista gastos empleados bloques marca_logo metodo_pago moto_barrios envio_venta notificaciones cliente_perfil reposicion reposicion_pedidos compras caja reclamos mercadopago notificaciones_v2) do (
        if exist "database\schema_%%F.sql" (
            echo     - schema_%%F.sql
            %MYSQL% britech_v2 < "database\schema_%%F.sql" || goto error_sql
        )
    )
    echo   Base lista. Admin: admin@britech.local / admin1234
)

:base_existe
REM La base existe pero quedo a medio importar (falta una tabla de los ultimos schemas)?
%MYSQL% %DBNAME% -e "SELECT 1 FROM reclamo_mensaje LIMIT 1" >nul 2>&1
if errorlevel 1 (
    echo.
    echo   [ERROR] La base %DBNAME% existe pero esta INCOMPLETA ^(una importacion anterior fallo^).
    echo   Borrala y volve a abrir este archivo para que la cree de cero:
    echo     "%MYSQLBIN%\mysql.exe" -u root -e "DROP DATABASE %DBNAME%"
    pause & exit /b 1
)

echo.
echo   Britech corriendo en:
echo   -^> http://127.0.0.1:8123/login.html   (staff: admin / vendedor)
echo   -^> http://127.0.0.1:8123/tienda.html  (clientes)
echo.
echo   (No cierres esta ventana mientras uses la app)
echo.
"%PHP%" -S 127.0.0.1:8123 -t public public\index.php
pause
exit /b 0

:error_sql
echo.
echo   [ERROR] Fallo la importacion de la base. Revisa el mensaje de arriba.
echo   Para reintentar desde cero borra la base:  mysql -u root -e "DROP DATABASE britech_v2"
pause
exit /b 1
