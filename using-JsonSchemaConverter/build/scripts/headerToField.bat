@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  headerToField startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and HEADER_TO_FIELD_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto execute

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\headerToField-1.0-SNAPSHOT.jar;%APP_HOME%\lib\connect-api-3.0.0.jar;%APP_HOME%\lib\connect-utils-0.7.177.jar;%APP_HOME%\lib\kafka-json-schema-serializer-6.2.0.jar;%APP_HOME%\lib\log4j-slf4j-impl-2.19.0.jar;%APP_HOME%\lib\log4j-core-2.19.0.jar;%APP_HOME%\lib\log4j-api-2.19.0.jar;%APP_HOME%\lib\kafka-json-schema-provider-6.2.0.jar;%APP_HOME%\lib\kafka-schema-serializer-6.2.0.jar;%APP_HOME%\lib\kafka-json-serializer-6.2.0.jar;%APP_HOME%\lib\kafka-schema-registry-client-6.2.0.jar;%APP_HOME%\lib\common-config-6.2.0.jar;%APP_HOME%\lib\common-utils-6.2.0.jar;%APP_HOME%\lib\mbknor-jackson-jsonschema_2.13-1.0.39.jar;%APP_HOME%\lib\kafka-clients-6.2.0-ccs.jar;%APP_HOME%\lib\avro-1.10.1.jar;%APP_HOME%\lib\slf4j-api-1.7.30.jar;%APP_HOME%\lib\javax.ws.rs-api-2.1.1.jar;%APP_HOME%\lib\value-2.8.2.jar;%APP_HOME%\lib\jackson-datatype-guava-2.10.5.jar;%APP_HOME%\lib\guava-31.1-jre.jar;%APP_HOME%\lib\freemarker-2.3.31.jar;%APP_HOME%\lib\zstd-jni-1.4.9-1.jar;%APP_HOME%\lib\lz4-java-1.7.1.jar;%APP_HOME%\lib\snappy-java-1.1.8.1.jar;%APP_HOME%\lib\failureaccess-1.0.1.jar;%APP_HOME%\lib\listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar;%APP_HOME%\lib\jsr305-3.0.2.jar;%APP_HOME%\lib\checker-qual-3.12.0.jar;%APP_HOME%\lib\error_prone_annotations-2.11.0.jar;%APP_HOME%\lib\j2objc-annotations-1.3.jar;%APP_HOME%\lib\org.everit.json.schema-1.12.2.jar;%APP_HOME%\lib\jackson-datatype-jdk8-2.10.5.jar;%APP_HOME%\lib\jackson-datatype-joda-2.10.5.jar;%APP_HOME%\lib\jackson-datatype-jsr310-2.10.5.jar;%APP_HOME%\lib\jackson-module-parameter-names-2.10.5.jar;%APP_HOME%\lib\kotlin-stdlib-1.4.21.jar;%APP_HOME%\lib\jackson-databind-2.11.3.jar;%APP_HOME%\lib\jersey-common-2.34.jar;%APP_HOME%\lib\jakarta.ws.rs-api-2.1.6.jar;%APP_HOME%\lib\swagger-annotations-1.6.2.jar;%APP_HOME%\lib\json-20201115.jar;%APP_HOME%\lib\commons-validator-1.6.jar;%APP_HOME%\lib\handy-uri-templates-2.1.8.jar;%APP_HOME%\lib\re2j-1.3.jar;%APP_HOME%\lib\jackson-core-2.11.3.jar;%APP_HOME%\lib\jackson-annotations-2.11.3.jar;%APP_HOME%\lib\joda-time-2.10.2.jar;%APP_HOME%\lib\scala-library-2.13.1.jar;%APP_HOME%\lib\kotlin-scripting-compiler-embeddable-1.3.50.jar;%APP_HOME%\lib\validation-api-2.0.1.Final.jar;%APP_HOME%\lib\classgraph-4.8.21.jar;%APP_HOME%\lib\kotlin-stdlib-common-1.4.21.jar;%APP_HOME%\lib\annotations-13.0.jar;%APP_HOME%\lib\commons-compress-1.20.jar;%APP_HOME%\lib\jakarta.annotation-api-1.3.5.jar;%APP_HOME%\lib\jakarta.inject-2.6.1.jar;%APP_HOME%\lib\osgi-resource-locator-1.0.3.jar;%APP_HOME%\lib\commons-digester-1.8.1.jar;%APP_HOME%\lib\commons-logging-1.2.jar;%APP_HOME%\lib\commons-collections-3.2.2.jar;%APP_HOME%\lib\kotlin-scripting-compiler-impl-embeddable-1.3.50.jar;%APP_HOME%\lib\kotlin-scripting-jvm-1.3.50.jar;%APP_HOME%\lib\kotlin-scripting-common-1.3.50.jar;%APP_HOME%\lib\kotlinx-coroutines-core-1.1.1.jar;%APP_HOME%\lib\kotlin-reflect-1.3.50.jar;%APP_HOME%\lib\kotlin-script-runtime-1.3.50.jar


@rem Execute headerToField
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %HEADER_TO_FIELD_OPTS%  -classpath "%CLASSPATH%" JsonSchemaProducer %*

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable HEADER_TO_FIELD_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%HEADER_TO_FIELD_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
