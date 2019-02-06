#!/bin/bash
DOMAIN=$(echo $CERTBOT_DOMAIN | grep -Eo '(\w+\.\w+)$')
CHALLENGE_RECORD="_acme-challenge.$CERTBOT_DOMAIN"

curl -X POST -H "Content-Type: text/xml" \
    -H 'SOAPAction: nameserverRRDelete' \
    --netrc-file ./login.txt \
    --silent \
    --data \
'<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://soap.domain-bestellsystem.de/soap/1.1/">
   <soapenv:Header/>
   <soapenv:Body>
      <ns:nameserverRRDelete soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
         <nameserverRRDeleteRequest xsi:type="ns:NameserverRRDeleteRequestObject">
            <soaOrigin xsi:type="xsd:string">'"$DOMAIN"'</soaOrigin>
            <rr xsi:type="ns:NameserverRRElement">
               <name xsi:type="xsd:string">'"$CHALLENGE_RECORD"'</name>
               <type xsi:type="xsd:string">TXT</type>
               <data xsi:type="xsd:string">'"$CERTBOT_VALIDATION"'</data>
               <aux xsi:type="xsd:string"></aux>
               <ttl xsi:type="xsd:string">300</ttl>
            </rr>
         </nameserverRRDeleteRequest>
      </ns:nameserverRRDelete>
   </soapenv:Body>
</soapenv:Envelope>' \
    https://soap.domain-bestellsystem.de/soap.php
