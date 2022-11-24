# -- Set up Reporting configuration

touch /etc/config/reporting
uci add reporting settings
uci set reporting.@settings[0].interval=1
uci set reporting.@settings[0].save_report=0
uci set reporting.@settings[0].send_email=0
uci set reporting.@settings[0].log=0
uci set reporting.@settings[0].clear_log=0
uci set reporting.@settings[0].survey=0
uci set reporting.@settings[0].duration=15
uci set reporting.@settings[0].client=0
uci set reporting.@settings[0].tracking=0

uci add reporting ssmtp

uci commit reporting

exit 0