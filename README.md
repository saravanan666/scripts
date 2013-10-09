scripts
=======

subtitle_adjuster.pl


usage: "perl subtitle_adjuster.pl input_file output_file seconds_to_shift +/-"

desktop-notify.sh

Script uses ubuntu's 'notify-send' command which displays notifications.

OSSEC active response config:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<ossec_config>
......
  <command>
    <name>desktop-notify</name>
    <executable>desktop-notify.sh</executable>
    <expect></expect>
  </command>  
  <active-response>
    <disabled>no</disabled> 
    <command>desktop-notify</command>
    <location>local</location> 
    <rules_id>1002,2902,533</rules_id>
  </active-response>
.......
</ossec_config>
