import logging
import os

bot_id = os.environ.get('BOT_TOKEN')

BACKEND = "SlackV3"  # Errbot will start in text mode (console only mode) and will answer commands from there.
BOT_EXTRA_BACKEND_DIR="/home/errbotuser/chatops/backend"

BOT_IDENTITY = {
	'token': bot_id
}


BOT_DATA_DIR = r"/home/errbotuser/chatops/data"
BOT_EXTRA_PLUGIN_DIR = r"/home/errbotuser/chatops/plugins"

BOT_LOG_FILE = r"/home/errbotuser/chatops/errbot.log"
BOT_LOG_LEVEL = logging.INFO

BOT_ADMINS = (
    "@CHANGE_ME",
)  # Don't leave this as "@CHANGE_ME" if you connect your errbot to a chat system!!

