#!/usr/bin/python

import argparse
import subprocess
import sys
import time

PARSER = argparse.ArgumentParser(description='Utilties for animation using tmux')
PARSER.add_argument('--tmux-session', '-S', type=str, help='Animate in this tmux session')

parsers = PARSER.add_subparsers(dest='command')
type_parser = parsers.add_parser('type', help='Type a string with tmux')
type_parser.add_argument('window', type=str, help='Window to type in')
type_parser.add_argument('--speed', type=float, help='Type this many times faster to type', default=1.0)


args = PARSER.parse_args()

if args.tmux_session is not None:
    tmux_command = ['tmux', '-S', args.tmux_session]
else:
    tmux_command = ['tmux']

if args.command == 'type':
    character_delay = 0.2 / args.speed
    for c in sys.stdin.read():
        subprocess.check_call(tmux_command + ['send-keys', '-t', args.window, c])
        time.sleep(character_delay)
else:
	raise ValueError(args.command)
