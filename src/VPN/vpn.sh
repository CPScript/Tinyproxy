import curses

def vpn_menu(stdscr):
    stdscr.clear()
    stdscr.addstr(0, 0, "VPN Setup - Choose Type")
    stdscr.addstr(1, 0, "1. OpenVPN")
    stdscr.addstr(2, 0, "2. WireGuard")
    stdscr.addstr(3, 0, "Press any key to return to main menu.")
    stdscr.refresh()
    stdscr.getch()

    vpn_type = input("Enter VPN type (openvpn/wireguard): ")
    if vpn_type == "openvpn":
        bashCommand = "bash scripts/setup_vpn.sh openvpn"
        process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
        output, error = process.communicate()
        stdscr.addstr(4, 0, "OpenVPN setup complete.")
    elif vpn_type == "wireguard":
        bashCommand = "bash scripts/setup_vpn.sh wireguard"
        process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
        output, error = process.communicate()
        stdscr.addstr(4, 0, "WireGuard setup complete.")
    else:
        stdscr.addstr(4, 0,
