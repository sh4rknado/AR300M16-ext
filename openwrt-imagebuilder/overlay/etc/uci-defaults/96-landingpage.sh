# -- Set up Landing Page configuration

touch /etc/config/landingpage
uci add landingpage settings
uci set landingpage.@settings[0].autostart='0'

uci commit landingpage

exit 0