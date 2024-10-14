import curses
import subprocess

def settings_menu(stdscr):
    curses.curs_set(0)
    stdscr.clear()
    stdscr.refresh()

    curses.start_color()
    curses.init_pair(1, curses.COLOR_WHITE, curses.COLOR_BLUE)
    curses.init_pair(2, curses.COLOR_WHITE, curses.COLOR_BLACK)

    menu = ["Logging", "Firewall Rules", "Return to Main Menu"]
    current_row = 0

    while True:
        stdscr.clear()
        stdscr.addstr(0, 0, "Settings")
        for idx, row in enumerate(menu):
            if idx == current_row:
                stdscr.attron(curses.color_pair(1))
                stdscr.addstr(idx + 1, 0, row)
                stdscr.attroff(curses.color_pair(1))
            else:
                stdscr.addstr(idx + 1, 0, row)

        key = stdscr.getch()

        if key == curses.KEY_UP and current_row > 0:
            current_row -= 1
        elif key == curses.KEY_DOWN and current_row < len(menu) - 1:
            current_row += 1
        elif key == curses.KEY_ENTER or key in [10, 13]:
            if current_row == len(menu) - 1:
                break 
            elif current_row == 0:
                bashCommand = "bash scripts/configure_logging.sh"
                process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
                output, error = process.communicate()
                stdscr.addstr(len(menu) + 1, 0, "Logging configured.")
            elif current_row == 1:
                bashCommand = "bash scripts/configure_firewall.sh"
                process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
                output, error = process.communicate()
                stdscr.addstr(len(menu) + 1, 0, "Firewall rules configured.")

        stdscr.refresh()import curses

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
        bashCommand = "bash scripts/conf_logging.sh"
        process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
        output, error = process.communicate()
        stdscr.addstr(4, 0, "Logging configured.")
    elif setting == "firewall":
        bashCommand = "bash scripts/conf_firewall.sh"
        process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
        output, error = process.communicate()
        stdscr.addstr(4, 0, "Firewall rules configured.")
    else:
        stdscr.addstr(4, 0, "Invalid setting. Please try again.")
        stdscr.refresh()
        stdscr.getch()
