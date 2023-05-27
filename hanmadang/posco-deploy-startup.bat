ECHO Y | RMDIR /S C:\workset\bin\apache-tomcat-8.5.56-posco\webapps\ROOT
ECHO Y | RMDIR /S C:\workset\bin\apache-tomcat-8.5.56-posco\webapps\posco-git-0.0.1-SNAPSHOT

cd C:\workset\workspace-iusoft\posco-git\build\libs

for /F %%I in ('dir /b /o:-d *.war') do ( set file=%%I & goto :end )

:end

echo %file%

copy %file% C:\workset\bin\apache-tomcat-8.5.56-posco\webapps\posco-git-0.0.1-SNAPSHOT.war

