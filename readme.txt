
build
mvn clean compile package -DskipTests

run
java -jar target\hackathon-2.0.1-jar-with-dependencies.jar

access
http://localhost:8080/hackathon/services/submit

(submit request.xml using poster in firefox with ctrl+alt+p)

logs appear in $project_dir\hackathon.log