import curses

def settings_menu(stdscr):
    stdscr.clear()
    stdscr.addstr(0, 0, "Settings")
    stdscr.addstr(1, 0, "1. Logging")
    stdscr.addstr(2, 0, "2. Firewall Rules")
    stdscr.addstr(3, 0, "Press any key to return to main menu.")
    stdscr.refresh()
    stdscr.getch()

    setting = input("Enter setting to configure (logging/firewall): ")
    if setting == "logging":
        bashCommand = "bash scripts/configure_logging.sh"
        process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
        output, error = process.communicate()
        stdscr.addstr(4, 0, "Logging configured.")
    elif setting == "firewall":
        bashCommand = "bash scripts/configure_firewall.sh"
        process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
        output, error = process.communicate()
        stdscr.addstr(4, 0, "Firewall rules configured.")
    else:
        stdscr.addstr(4, 0, "Invalid setting. Please try again.")
        stdscr.refresh()
        stdscr.getch()
