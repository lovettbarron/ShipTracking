import sys, traceback, datetime, math, os
from time import clock, time
import urllib2
import wx
from xml.dom import minidom
from gis import *

class Run:
	def __init__(self):
		self.timerDif = float(time())
		self.curPos = None
		self.c = Gis(14567)

	def main(self):
		self.timerDif = float(time())
		while True:
			if self.timerDif <= time():
				self.curPos = self.c.curPosition( self.c.getFeed() )
				print self.c.calcGeoDist( self.curPos[0], self.curPos[1], float(0),float(0) )
				self.timerDif = time() + 30
			else:
				print "Time Remaining: " + str( self.timerDif - time() ) + ", Cur dist: " \
				+ str(self.c.calcGeoDist( self.curPos[0], self.curPos[1], float(0),float(0) ) )
				
if __name__.lower() == '__main__':
	r = Run()
	r.main()