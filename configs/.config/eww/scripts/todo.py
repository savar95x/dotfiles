#!/usr/bin/env python3
import json
import sys
import os

# Path to your JSON file
JSON_FILE = os.path.expanduser("~/.config/eww/scripts/tasks.json")

def load_tasks():
    with open(JSON_FILE, 'r') as f:
        return json.load(f)

def save_tasks(tasks):
    with open(JSON_FILE, 'w') as f:
        json.dump(tasks, f, indent=2)

def toggle_task(task_id):
    tasks = load_tasks()
    for task in tasks:
        if task['id'] == int(task_id):
            task['done'] = not task['done']
    save_tasks(tasks)
    # Print the new list so Eww can update the variable immediately
    print(json.dumps(tasks))

def main():
    if len(sys.argv) < 2:
        return

    command = sys.argv[1]

    if command == "read":
        print(json.dumps(load_tasks()))
    elif command == "toggle":
        toggle_task(sys.argv[2])

if __name__ == "__main__":
    main()
