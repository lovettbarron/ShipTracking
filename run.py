import sys, traceback, datetime, math
from lib.main import *

def main():
	r = Run()
	r.main()	

if __name__.lower() == '__main__':  
    try:
       main()
    except Exception, e:
        tb = sys.exc_info()[2]
        traceback.print_exception(e.__class__, e, tb)