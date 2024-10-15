### setup

* 1. `chmod +x setup.sh proxy_manager.py ui.py proxy_server.py`
* 2. `./setup.sh`
* 3. `python proxy_manager.py`
* 4. **Exiting the Application**: To exit the application, press the q key as indicated in the user interface.


### output
> header
```
Proxy Server Management
```

> Status Information
```
Uptime: 0m 0s                     (or the actual uptime if the proxy has been started)
Connection Status: Stopped         (or Running if the proxy is active)
Public IP: [Your Public IP]       (e.g., 203.0.113.1)
Local IP: [Your Local IP]         (e.g., 192.168.1.2)
```

> discription
```
Connect your device using this proxy:
Set proxy to: <local_ip>:8888
Make sure to allow connections from your device.
```

> action buttons
```
[START] Press 's' to toggle the proxy
[Q] Press 'q' to quit
```
