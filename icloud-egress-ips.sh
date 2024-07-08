#!/bin/sh

# Apple's iCloud Egress IP-Ranges summarized by /16 for IPv4 and /32 for IPv6
# Wolfgang Lauffher 2024

curl --silent --fail https://mask-api.icloud.com/egress-ip-ranges.csv \
| gawk -F "[:.]" '

	/^[[:digit:]]+\./ {		# v4 has some digits "0-9" followed by "."
		v4_16[$1 "." $2]++
	}

	/^[[:xdigit:]]+:/ {		# v6 has some chars "0-9a-f" followed by ":"
		v6_32[$1 ":" $2]++
	}

	END {
		for (entry in v4_16) printf "%-10s has %7s rows\n", entry, v4_16[entry]
		for (entry in v6_32) printf "%-10s has %7s rows\n", entry, v6_32[entry]
	}
'

# vim: syntax=awk
