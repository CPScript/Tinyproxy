import curses

def vpn_menu(stdscr):
    stdscr.clear()
    stdscr.addstr(0, 0, "VPN Setup - Choose Type")
    stdscr.addstr(1, 0, "1. OpenVPN")
    stdscr.addstr(2, 0, "2. WireGuard")
    stdscr.addstr(3, 0, "Press any key to return to main menu.")
    stdscr.refresh()
    stdscr.getch()

    # VPN setup
    vpn_type = input("Enter VPN type (openvpn/wireguard): ")
    if vpn_type == "openvpn":
        stdscr.addstr(4, 0, "Setting up OpenVPN...")
        stdscr.refresh()
        bashCommand = "bash scripts/setup_vpn.sh openvpn"
        process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
        output, error = process.communicate()
        stdscr.addstr(5, 0, "OpenVPN setup complete.")
    elif vpn_type == "wireguard":
        stdscr.addstr(4, 0, "Setting up WireGuard...")
        stdscr.refresh()
        bashCommand = "bash scripts/setup_vpn.sh wireguard"
        process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
        output, error = process.communicate()
        stdscr.addstr(5, 0, "WireGuard setup complete.")
    else:
        stdscr.addstr(4, 0, "Invalid VPN type. Please try again.")
        stdscr.refresh()
        stdscr.getch()
