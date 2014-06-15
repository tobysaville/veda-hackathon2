
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

service root:
 http://54.79.47.19:7474/db/data/cypher
 
 browse
 http://54.79.47.19:7474/browser/

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



create a node
 http://54.79.47.19:7474/db/data/node
 



query rest template;


{
  "query" : "MATCH (a {Postcode: '2060'}) RETURN a.id",
  "params" : {
  }
}





can append ?includeStats=true to the query url



creating relationships

overview
would be good to say here is an address. it represents a postcode.
it has relationships to businesses in that postcode.
those businesses have an abn. that abn links them to securities that they are the grantors of. 
businesses may have a business name. and those busness names can show what credit that user has provided. 
other accounts may be linked to individuals. we also have that information

so it goes 
address 	-HAS> business 	-GRANTOR> securities
							-CREDITS>   accounts			-OWNED_BY> identities



node ids

address
652, 870, 574

business
330, 454, 261, 471, 304
327, 331, 218, 328, 213

securities
773, 779, 722, 753, 804, 791


accounts
1028, 1029, 1034

identities
1012, 1000, 561



Relationship REST 

Address HAS Business
POST http://54.79.47.19:7474/db/data/node/652/relationships
{
  "to" : "http://54.79.47.19:7474/db/data/node/330",
  "type" : "HAS"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/454",
  "type" : "HAS"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/261",
  "type" : "HAS"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/471",
  "type" : "HAS"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/304",
  "type" : "HAS"
}

BUSINESS IS_GRANTOR for Security

POST 
http://54.79.47.19:7474/db/data/node/330/relationships
{
  "to" : "http://54.79.47.19:7474/db/data/node/773",
  "type" : "IS_GRANTOR"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/779",
  "type" : "IS_GRANTOR"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/772",
  "type" : "IS_GRANTOR"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/753",
  "type" : "IS_GRANTOR"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/804",
  "type" : "IS_GRANTOR"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/791",
  "type" : "IS_GRANTOR"
}

BUSINESS CREDITS Account

POST http://54.79.47.19:7474/db/data/node/454/relationships
{
  "to" : "http://54.79.47.19:7474/db/data/node/1028",
  "type" : "CREDITS"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/1029",
  "type" : "CREDITS"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/1034",
  "type" : "CREDITS"
}

ACCOUNT BELONGS_TO
POST http://54.79.47.19:7474/db/data/node/1028/relationships
{
  "to" : "http://54.79.47.19:7474/db/data/node/1012",
  "type" : "BELONGS_TO"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/1000",
  "type" : "BELONGS_TO"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/561",
  "type" : "BELONGS_TO"
}





updating properties
business 454
needs to be in postcode=2060, state=NSW, location=NORTH SYDNEY, organisation=VEDA

MATCH (n:Business { organisation: 'Dj & Ma Milne' })
SET n.postcode = '2060', n.state = 'NSW', n.location='NORTH SYDNEY'



MATCH (n:Business { organisation: '2 Penguins Leisure & Sports' })
SET n.postcode = '2060', n.state = 'NSW', n.location='NORTH SYDNEY', n.organisation='Veda Advantage'





add more businesses to address 652



account latest-credit-provider
MATCH (n:Account{`latest-credit-provider`:'NAB'})
set n.`latest-credit-provider`='NAB'


MATCH (n:Identity{`first-given-name`:'FIRSTCONSUMER'})
set n.`other-given-name`='Moneybags', n.`first-given-name`='Asad', n.`family-name`='Nasir', n.`is-deceased`='false'

FIRSTCONSUMER





requests

1038

link to account 1029


create 2 (gsrch?) requests to link to some securities - show cross relationships


create a request to link to an ID

create a request that links to two nodes



GRANTOR SEARCH REQUEST - 1045, 1046
{
  "query" : "CREATE (n:Request { props } ) RETURN n",
  "params" : {
    "props" : {
    "MemberCode": "CRED",
    "BranchCode": "0003",
    "CustomersRequestMessageId": "140612-SN02W-00006",
    "OrganisationName": "Veda Advantage",
    "GrantorType": "Organisation",
    "IncludeArchived": "false",
    "IncludeCurrent": "true",
    "IncludeExpired": "false",
    "IncludeMigratedTransitional": "true",
    "IncludeNonMigratedTransitional": "true",
    "IncludeNonTransitional": "true",
    "IncludeRemoved": "false",
    "IsPMSISearchCriteria": "Either",
    "RegistrationNumberSortOrder": "Descending",
    "SecurityInterestsOnly": "false",
    "Type":"SearchByGrantorRequest"
  }
  }
}
TODO: write a query to match on member code and/or uuid

ID MATRIX CREATE REQUEST - 1044
{
  "query" : "CREATE (n:Request { props } ) RETURN n",
  "params" : {
    "props" : 
{
    "UUID": "140604-V1HL0-02WY9",
    "MemberCode": "CRED",
    "BranchCode": "0003",
    "SubscriberIdentifier": "TestMatrixUs",
    "family-name": "Nasir",
    "first-given-name": "ASAD",
    "other-given-name": "MoneyBags",
    "date-of-birth": "1981-10-14",
    "unformatted-address": "1 5 WILSON ST HORSHAM VIC 3400",
    "drivers-licence-number": "2014730138",
    "passport-number": "APP12341234",
    "medicare-number": "1234567891",
    "birth-certificate-registration-number": "BIRTH12341234",
    "type": "IDMatrix"
  }
  
  }
}

(ATTACH AN ADDRESS TO THIS REQUEST)



VEDASCORE REQUEST - 1043, 1042, 1038 (no type)


{
  "query" : "CREATE (n:Request { props } ) RETURN n",
  "params" : {
    "props" : 
    
{
    "enquiry-id": "140512-VSA04-TEST7",
    "datetime-requested": "2013-11-24T01:44:07",
    "member-code": "CRED",
    "branch-code": "0003",
    "client-reference": "Client Ref 1",
    "operator-id": "I1RZ",
    "operator-name": "PAUL",
    "permission-type-code": "XY",
    "product-data-level-code": "C",
    "bureau-reference": "13093500",
    "account-type-code": "CC",
    "enquiry-amount": "2399",
    "relationship-code": "1",
    "enquiry-client-reference": "Client Ref2",
    "type": "VedaScoreApply"
  }

  
  }
}  

link gs request 1045 to security 804, 791, 779 and to business 330
link gs request 1046 to security 772, 779, 727 


GrantorSearch RETURNED SECURITY
POST http://54.79.47.19:7474/db/data/node/1045/relationships
{
  "to" : "http://54.79.47.19:7474/db/data/node/804",
  "type" : "BELONGS_TO"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/791",
  "type" : "BELONGS_TO"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/779",
  "type" : "BELONGS_TO"
}

GrantorSearch MATCHED Business
POST http://54.79.47.19:7474/db/data/node/1045/relationships
{
  "to" : "http://54.79.47.19:7474/db/data/node/330",
  "type" : "BELONGS_TO"
}

GrantorSearch RETURNED SECURITY
POST http://54.79.47.19:7474/db/data/node/1046/relationships
{
  "to" : "http://54.79.47.19:7474/db/data/node/772",
  "type" : "BELONGS_TO"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/779",
  "type" : "BELONGS_TO"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/727",
  "type" : "BELONGS_TO"
}



link vsa request 1043 to account 1034, 

POST http://54.79.47.19:7474/db/data/node/1043/relationships
{
  "to" : "http://54.79.47.19:7474/db/data/node/1034",
  "type" : "MATCHED"
}

link vsa request 1042 to account 1028, 1029
POST http://54.79.47.19:7474/db/data/node/1042/relationships
{
  "to" : "http://54.79.47.19:7474/db/data/node/1028",
  "type" : "MATCHED"
}
{
  "to" : "http://54.79.47.19:7474/db/data/node/1029",
  "type" : "MATCHED"
}




link idm request 1044 to address 891 
http://54.79.47.19:7474/db/data/node/1044/relationships
{
  "to" : "http://54.79.47.19:7474/db/data/node/891",
  "type" : "MATCHED"
}

link idm request 1044 to id 561

http://54.79.47.19:7474/db/data/node/1044/relationships
{
  "to" : "http://54.79.47.19:7474/db/data/node/561",
  "type" : "MATCHED"
}
  