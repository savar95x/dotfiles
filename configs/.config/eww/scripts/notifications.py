#!/usr/bin/env python3
import json
import sys
import os

# File to store notification history
CACHE_FILE = os.path.expanduser("~/.cache/eww_notifications.json")

def read_history():
    if not os.path.exists(CACHE_FILE):
        # Default Dummy Data for first run
        return [
            {"id": 1, "app": "Discord", "title": "Gruvbox Enjoyer", "body": "Hey, have you tried the new Eww update?", "icon": "discord", "time": "2m ago"},
            {"id": 2, "app": "System", "title": "Low Battery", "body": "Battery is at 10%. Connect charger.", "icon": "battery-level-10-symbolic", "time": "10m ago"},
            {"id": 3, "app": "Spotify", "title": "Now Playing", "body": "Pink Floyd - Time", "icon": "spotify", "time": "1h ago"},
        ]
    with open(CACHE_FILE, 'r') as f:
        return json.load(f)

def save_history(data):
    with open(CACHE_FILE, 'w') as f:
        json.dump(data, f)
    print(json.dumps(data))

command = sys.argv[1] if len(sys.argv) > 1 else "read"

if command == "read":
    print(json.dumps(read_history()))

elif command == "clear":
    save_history([])

elif command == "dismiss":
    # Usage: python notifications.py dismiss <id>
    notif_id = int(sys.argv[2])
    data = [n for n in read_history() if n['id'] != notif_id]
    save_history(data)

elif command == "add":
    # For testing: python notifications.py add "App" "Title" "Body"
    data = read_history()
    new_id = (data[0]['id'] + 1) if data else 1
    new_item = {
        "id": new_id,
        "app": sys.argv[2],
        "title": sys.argv[3],
        "body": sys.argv[4],
        "icon": "dialog-information", 
        "time": "Just now"
    }
    data.insert(0, new_item)
    save_history(data)
