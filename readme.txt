
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

http://127.0.0.1:8080/hackathon/services/screech



neo4j

reset service root:
 http://localhost:7474/db/data/cypher

delete address and registrations
MATCH (a:Address),(m:Registration) OPTIONAL MATCH (a)-[r1]-(), (m)-[r2]-() DELETE a,r1,m,r2

find all nodes
MATCH (n) RETURN n


find 10 nodes
MATCH (people:Person) RETURN people.name LIMIT 10


match on a field
MATCH (a {Postcode: "2060"}) RETURN a

good match examples
http://docs.neo4j.org/chunked/milestone/query-match.html





query rest template;


{
  "query" : "MATCH (a {Postcode: '2060'}) RETURN a.id",
  "params" : {
  }
}





can append ?includeStats=true to the query url

