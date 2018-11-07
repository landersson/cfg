# this will make python REPL completion more likely to work in virtualenvs
import readline
import rlcompleter
readline.parse_and_bind("tab: complete")
