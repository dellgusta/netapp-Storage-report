# netapp-Storage-report
Generates a TXT based file which contains information to be consumed by macros and create elaborate reports about NAS NetApp environment under DFM Linux Server

Requirements:

- DFM Linux Server;
- Authless ssh connection configured between DFM Linux server and your Storage devices;
- storage_list file:
  -  TXT based file. Each line should contain a Storage device you want to collect information from. It can be the hostname or IP, depending on your "hosts" file;
- Same directory structure as seen in this repository. Both "tmp" and "report" should exist where the script is being executed.
- The main script should have execution permission: *$sudo chmod +x <script>* should do the magic.
