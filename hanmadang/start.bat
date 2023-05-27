
for /F %%I in ('dir /b /o:-d build\libs\*.war') do ( set file=%%I & goto :end )

:end

copy build\libs\%file% C:\workset\bin\apache-tomcat-9.0.36\webapps\posco-git-0.0.1-SNAPSHOT.war

cd C:\workset\bin\apache-tomcat-9.0.36\bin
startup.bat

pause