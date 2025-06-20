#!/usr/bin/python3

import os
from pathlib import PurePath

from Alfred3 import Items, Tools


def get_entries(r_path):
    entries = []
    for p in os.listdir(r_path):
        if p.startswith('.') or p == '.DS_Store':
            continue  # скрытые и системные — пропустить
        full_path = os.path.join(r_path, p)
        if os.path.isdir(full_path) or os.path.isfile(full_path):
            entries.append(full_path)
    return entries


Tools.logPyVersion()

f_path = Tools.getEnv('mypath')
Tools.log(f"this is f_path: {f_path}")

ws_home = f_path if f_path else os.path.expanduser(Tools.getEnv('workspaces_home'))

wf = Items()
entries = get_entries(ws_home)

if len(entries) > 0:
    for i in sorted(entries):
        is_dir = os.path.isdir(i)
        is_workspace = i.endswith('.code-workspace')
        title = os.path.basename(i).replace('.code-workspace', '')

        # Определяем иконку и описание
        if is_dir:
            icon = 'folder.png'
            subtitle = 'Folder'
        elif is_workspace:
            icon = 'workspace.png'
            subtitle = 'Workspace in VSCode'
        else:
            icon = 'file.png'
            subtitle = 'File'

        # Подсказки по модификаторам
        mods = {
            "cmd": {
                "valid": True,
                "arg": i,
                "subtitle": f"⌘ to open {'folder' if is_dir else 'file'} in VSCode"
            },
            "alt": {
                "valid": True,
                "arg": i,
                "subtitle": "⌥ to reveal in Finder"
            }
        }

        wf.setItem(
            title=title,
            subtitle=f"↩ to open {subtitle}",
            arg=i,
            mods=mods
        )
        wf.setIcon(m_path=icon, m_type='image')
        wf.addItem()
else:
    wf.setItem(
        title="No folders, workspace files or files found",
        valid=False
    )
    wf.addItem()

wf.write()