import curses

def proxy_menu(stdscr):
    stdscr.clear()
    stdscr.addstr(0, 0, "Proxy Setup - Choose Type")
    stdscr.addstr(1, 0, "1. HTTP Proxy")
    stdscr.addstr(2, 0, "2. SOCKS Proxy")
    stdscr.addstr(3, 0, "Press any key to return to main menu.")
    stdscr.refresh()
    stdscr.getch()

    proxy_type = input("Enter proxy type (http/socks): ")
    if proxy_type == "http":
        bashCommand = "bash scripts/setup_proxy.sh http"
        process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
        output, error = process.communicate()
        stdscr.addstr(4, 0, "HTTP Proxy setup complete.")
    elif proxy_type == "socks":
        bashCommand = "bash scripts/setup_proxy.sh socks"
        process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
        output, error = process.communicate()
        stdscr.addstr(4, 0, "SOCKS Proxy setup complete.")
    else:
        stdscr.addstr(4, 0, "Invalid proxy type. Please try again.")
        stdscr.refresh()
        stdscr.getch()
