import curses
import subprocess

def proxy_menu(stdscr):
    curses.curs_set(0)
    stdscr.clear()
    stdscr.refresh()

    curses.start_color()
    curses.init_pair(1, curses.COLOR_WHITE, curses.COLOR_BLUE)
    curses.init_pair(2, curses.COLOR_WHITE, curses.COLOR_BLACK)

    menu = ["HTTP Proxy", "SOCKS Proxy", "Return to Main Menu"]
    current_row = 0

    while True:
        stdscr.clear()
        stdscr.addstr(0, 0, "Proxy Setup - Choose Type")
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
                bashCommand = "bash scripts/setup_proxy.sh http"
                process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
                output, error = process.communicate()
                stdscr.addstr(len(menu) + 1, 0, "HTTP Proxy setup complete.")
            elif current_row == 1:
                bashCommand = "bash scripts/setup_proxy.sh socks"
                process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
                output, error = process.communicate()
                stdscr.addstr(len(menu) + 1, 0, "SOCKS Proxy setup complete.")

        stdscr.refresh()
