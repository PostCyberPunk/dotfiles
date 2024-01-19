#!/usr/bin/fish
if test -d /usr/lib/systemd/system-generators-backup
    rm -rf /usr/lib/systemd/system-generators-backup && mkdir /usr/lib/systemd/system-generators-backup
else
    mkdir /usr/lib/systemd/system-generators-backup
end
mv /usr/lib/systemd/system-generators/systemd-gpt-auto-generator /usr/lib/systemd/system-generators-backup/systemd-gpt-auto-generator.bak
