# Code for Remote Client

enable-psremoting on Targetserver B as admin
Set-PSSessionConfiguration -Name Microsoft.PowerShell -ShowSecurityDescriptorUI on Targetserver B as admin
Add "usser" with full privileges
Now comes the exciting part:

sc sdshow scmanager on Targetserver B as admin

Copy the SDDL output

sc sdset scmanager (f.e.:)"D:(A;;CC;;;AU)(A;;CCLCRPRC;;;IU)(A;;CCLCRPRC;;;SU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)" , in the Output you have to fill after this part (A;;CCLCRPWPRC;;;SY) this = (A;;KA;;;SID)

SID stands of course for the SID of the unprivileged "usser"-user

when everything should be fine, it will similiar looks like this :

D:(A;;CC;;;AU)(A;;CCLCRPRC;;;IU)(A;;CCLCRPRC;;;SU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;S-1-5-21-4233383628-1788409597-1873130553-1161)(A;;KA;;;BA)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)

>>>
https://stackoverflow.com/questions/10744903/cant-use-get-service-computername-on-remote-computer

Steps:

From elevated powershell prompt on targetserver B, run enable-psremoting. Accept several Y/N dialog confirmations or else run with -force switch.
In same elevated prompt as step 1, Set-PSSessionConfiguration -Name Microsoft.PowerShell -ShowSecurityDescriptorUI
In the resulting dialog, add "user1". Read privileges should be sufficient unless you are planning on remotely manipulating services, in which case you will want Full Control.
On targetserver B, from an elevated (non-powershell) prompt or as an administrator, run sc sdshow scmanager. Copy the SDDL output. May look something like this: D:(A;;CC;;;AU)(A;;CCLCRPRC;;;IU)(A;;CCLCRPRC;;;SU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)
UPDATE: If we add the limited user to the target computer's Remote Management Users group, we can add (A;;LCRPWPDTLO;;;RM) to the D: portion of the above SDDL string, and skip steps 5 and 6 below.

Determine the SID of the underprivileged user account (in our case, "user1"). (Hint: try wmic useraccount where name='user1' get sid)
Insert the following text into the output we copied in step 5: (A;;KA;;;*SID*) where *SID* is the SID of the user determined in step 5. Insert it somewhere in a place before the S: part of the SDDL string retrieved in step 4. So now you should have a string looking something like this: D:(A;;CC;;;AU)(A;;CCLCRPRC;;;IU)(A;;CCLCRPRC;;;SU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;S-1-5-21-4233383628-1788409597-1873130553-1161)(A;;KA;;;BA)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)
On targetserver B, run sc sdset scmanager followed by our new modified SDDL string. So the entire command would look something like this: sc sdset scmanager D:(A;;CC;;;AU)(A;;CCLCRPRC;;;IU)(A;;CCLCRPRC;;;SU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;S-1-5-21-4233383628-1788409597-1873130553-1161)(A;;KA;;;BA)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)
You should now be able to remotely access the Service Control Manager on the remote server while logged into client machine A as "user1".