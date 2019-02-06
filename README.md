# Certbot Hooks for domain-bestellsystem.de

## Setup

Create `login.txt`:

```text
machine soap.domain-bestellsystem.de
login <username>
password <password>
```

Make sure to make this file only readable for root:

`sudo chmod 0400 ./login.txt`

## Get certificate

Run Certbot in manual mode:

`sudo certbot certonly --manual --preferred-challenges dns --manual-auth-hook ./auth-hook.sh --manual-cleanup-hook ./cleanup-hook.sh -d example.com -d *.example.com`

This will generate a wildcard certificate for your domain without the need to manually enter the TXT records.
