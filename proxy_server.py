import subprocess
import os
import time
from datetime import datetime

class ProxyServer:
    def __init__(self):
        self.is_running = False
        self.start_time = None
        self.tinyproxy_pid = None
        self.connected_devices = {} 

    def get_public_ip(self):
        return subprocess.getoutput("curl -s https://ipinfo.io/ip")

    def get_local_ip(self):
        return subprocess.getoutput("ip addr show wlan0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1")

    def start_tinyproxy(self):
        if not self.is_running:
            self.is_running = True
            self.start_time = time.time()
            self.tinyproxy_pid = subprocess.Popen(["/data/data/com.termux/files/usr/bin/tinyproxy"])

    def stop_tinyproxy(self):
        if self.tinyproxy_pid:
            os.kill(self.tinyproxy_pid.pid, 15)
            self.tinyproxy_pid.wait()
            self.is_running = False
            self.tinyproxy_pid = None

    def get_uptime(self):
        if self.start_time:
            uptime = int(time.time() - self.start_time)
            return f"{uptime // 60}m {uptime % 60}s"
        return "N/A"

    def connection_status(self):
        return "Running" if self.is_running else "Stopped"

    def add_connected_device(self, ip_address):
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        self.connected_devices[ip_address] = timestamp

    def get_connected_devices(self):
        return self.connected_devices
