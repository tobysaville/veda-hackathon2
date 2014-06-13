
test
RequestHandlerRouteTest.test()

build
mvn clean compile package -DskipTests

run
java -jar target\hackathon-2.0.1-jar-with-dependencies.jar
java -jar target/hackathon-2.0.1-jar-with-dependencies.jar

or

windows:
java -cp "target\dependency\*;target\hackathon-2.0.1.jar" com.veda.icc.esb.utilities.dumper.MainRunner
unix:
java -cp "hackathon-2.0.1.jar:dependency/*" com.veda.icc.esb.utilities.dumper.MainRunner


access
http://localhost:8080/hackathon/services/submit

(submit request.xml using poster in firefox with ctrl+alt+p)

logs appear in $project_dir\hackathon.log


loading screech

do a http post to the following containing the businesses the body

http://0.0.0.0:8080/hackathon/services/screech