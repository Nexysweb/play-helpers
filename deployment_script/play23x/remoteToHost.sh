ssh root@host 'bash -s' <<'ENDSSH'
  # commands to run on remote host
  cd /srv/www/...
  ./sh/prod.sh
ENDSSH