
for /F %%I in ('dir /b /o:-d build\libs\*.war') do ( set file=%%I & goto :end )

:end

copy build\libs\%file% C:\workset\bin\apache-tomcat-8.5.56-posco\webapps\posco-git-0.0.1-SNAPSHOT.war

cd C:\workset\bin\apache-tomcat-8.5.56-posco\bin
startup.bat

pause