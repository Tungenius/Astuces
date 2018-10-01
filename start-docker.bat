@echo off
SET VMNAME=default

SET -e

SET PARAM1=%~1
SET PARAM2=%~2

ECHO -------- Start machine --------
CALL docker-machine start %VMNAME%
CALL :check_error "Start machine"


ECHO ---------  Set env  -----------
ECHO @FOR /f "tokens=*" %%i IN ('docker-machine env --no-proxy') DO @%%i
@FOR /f "tokens=*" %%i IN ('docker-machine env --no-proxy') DO @%%i
CALL :check_error "Set env"

ECHO -------- Stop container --------
docker-compose stop
docker-compose rm -fv
CALL :check_error "Stop container"

REM run clean install
IF "%PARAM1%" == "--clean-install" (
    IF "%PARAM2%" == "--skip-test" (
        ECHO -------- Clean install with skip test --------
        CALL mvn clean install -Dmaven.test.skip
        CALL :check_error "Clean install with skip test"
    ) ELSE (
        ECHO -------- Clean install --------
        CALL mvn clean install
        CALL :check_error "Clean install"
    )
)

ECHO ------- Start container -------
ECHO docker-compose up -d --force-recreate --remove-orphans --build
docker-compose up -d --force-recreate --remove-orphans --build
CALL :check_error "Start container"

ECHO ------- Docker ps -------
docker ps
CALL :check_error "Docker ps"

EXIT /B 0

:check_error
if not "%ERRORLEVEL%" == "0" (
    ECHO %~1 KO! Return code was not zero but %ERRORLEVEL%
    EXIT /b %ERRORLEVEL%
)else (
    ECHO %~1 OK - Code : %ERRORLEVEL%
)
EXIT /B 0