#!/bin/bash

###This script looks at the user info in the JSS and renames the computer by using the current users first two initals and the Positon Defined in your LDAP



##Variables###
apiUsername="apiuser"
apiPassword="apipassword"
jssURL="your.jss.com"
###Do not modify below this line

currentUser=$(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')
userInitals=$(stat -f "%Su" /dev/console | cut -c1-2)


userInfo=$(curl -s -u $apiUsername:$apiPassword -X GET https://$jssURL:8443/JSSResource/users/name/$currentUser -H "Accept: application/xml" | sed "s@.*<position>\(.*\)</position>.*@\1@"
)

echo $userInfo

/usr/local/jamf/bin/jamf setComputername -name $userInitals$userInfo


