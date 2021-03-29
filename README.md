# netapp-Storage-report
Generates a TXT based file which contains information to be consumed by macros and create elaborate reports about NAS NetApp environment under DFM Linux Server

Requirements:

- DFM Linux Server;
- Authless ssh connection configured between DFM Linux server and your Storage devices;
- storage_list file:
  -  TXT based file. Each line should contain a Storage device you want to collect information from. It can be the hostname or IP, depending on your "hosts" file;
- Edit this part of the script to match your environment:
  ```
  #DECLARING VARIABLES
  SSH=/usr/bin/ssh
  ECHO=/bin/echo
  ECHOSPACE="echo """
  TEMPDIR=<dir of a tmp folder>
  STORAGELISTPATH=<path of storage_list file created above>
  ```
  And also:
  ```
  REPORTPATH=<dir of your report folder, make sure you keep the storage variable ahead or change the variable in for loop opening as well> /"$storage"_Report.txt
  ```
- The main script should have execution permission: ```$sudo chmod +x <script>``` should do the magic.
