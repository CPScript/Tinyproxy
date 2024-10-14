import curses
import os
from PROXY.proxy import proxy_menu
from VPN.vpn import vpn_menu
from SETT.set import settings_menu

def main_menu(stdscr):
    curses.curs_set(0)  
    stdscr.clear()
    stdscr.refresh()

    curses.start_color()
    curses.init_pair(1, curses.COLOR_WHITE, curses.COLOR_BLUE)  
    curses.init_pair(2, curses.COLOR_WHITE, curses.COLOR_BLACK)  

    menu = ['Set up Proxy', 'Set up VPN', 'Settings', 'Exit']
    current_row = 0

    while True:
        stdscr.clear()
        for idx, row in enumerate(menu):
            if idx == current_row:
                stdscr.attron(curses.color_pair(1)) 
                stdscr.addstr(idx, 0, row)
                stdscr.attroff(curses.color_pair(1))  
            else:
                stdscr.attron(curses.color_pair(2))  
                stdscr.addstr(idx, 0, row)
                stdscr.attroff(curses.color_pair(2))  

        key = stdscr.getch()

        if key == curses.KEY_UP and current_row > 0:
            current_row -= 1
        elif key == curses.KEY_DOWN and current_row < len(menu) - 1:
            current_row += 1
        elif key == curses.KEY_ENTER or key in [10, 13]:
            if current_row == len(menu) - 1:
                break  
            elif current_row == 0:
                proxy_menu(stdscr)
            elif current_row == 1:
                vpn_menu(stdscr)
            elif current_row == 2:
                settings_menu(stdscr)

        stdscr.refresh()

curses.wrapper(main_menu)
