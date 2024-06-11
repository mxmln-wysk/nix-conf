troubleshooting
if homemanger envoriment fails => run journalctl --use -f and look for the output


for Database Server: 
    https://jeancharles.quillet.org/posts/2022-01-30-Local-mariadb-server-with-nix-shell.html
    php -S localhost:8000
    nix-shell nix-shell.sh

but it works without it via:   
services.mysql = {
  enable = true;
  package = pkgs.mariadb;
};
aber dadurch wird der service immer gestartet
anmeldung mit root und root-passwort des PCs via phpmyAdmin(heruntergeladene Version)