#!/usr/bin/env python3

import sys
import os
import socket
import json

I3_CMD_COMMAND=0
I3_CMD_WORKSPACES=1
I3_CMD_OUTPUTS=3
I3_MAGIC=b'i3-ipc'

assert len(sys.argv)==3, "call with socket_path and workspace name"
i3=socket.socket(socket.AF_UNIX,socket.SOCK_STREAM)
i3.connect(sys.argv[1])

def int_to_bytes(x: int) -> bytes:
    return x.to_bytes(4, sys.byteorder)

def encode(cmd:int,msg:bytes) -> bytes:
    return I3_MAGIC+int_to_bytes(len(msg))+int_to_bytes(cmd)+msg

def recv_exact(l:int)->bytes:
    b=b'';
    while len(b)<l:
        b=b+i3.recv(l-len(b))
    return b

def recv_int()->int:
    return int.from_bytes(recv_exact(4),sys.byteorder)

def ipc_call(cmd:int,msg:str='')->bytes:
    i3.send(encode(cmd,msg.encode('utf8')))
    assert recv_exact(len(I3_MAGIC))==I3_MAGIC
    resp_len=recv_int()
    assert cmd==recv_int()
    return recv_exact(resp_len)

def ipc_get_json(cmd):
    return json.loads(ipc_call(cmd).decode('utf-8'))

def get_current_workspace():
    for ws in ipc_get_json(I3_CMD_WORKSPACES):
        if ws['focused']==True:
            return ws['name']
    raise Exception('no focused workspace')

def get_output_for_workspace(ws):
    for out in ipc_get_json(I3_CMD_OUTPUTS):
        if out['current_workspace']==ws:
            return out['name']
    raise Exception('no output for workspace %s'%ws)

target_ws=sys.argv[2]
target_output=get_output_for_workspace(get_current_workspace())
command=f'workspace {target_ws}; move workspace to output {target_output}'
print(command)
ipc_call(I3_CMD_COMMAND,command)
