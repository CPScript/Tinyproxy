import curses
from ui import ProxyManagerUI

if __name__ == "__main__":
    ui = ProxyManagerUI()
    curses.wrapper(ui.main)
