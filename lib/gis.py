import sys, traceback, datetime, math
import urllib2
from xml.dom import minidom
from main import *

class Gis:
	# param

	def __init__(self, feedid):
		self.feed_id = feedid
		global API_KEY
		global API_URL
		API_KEY = 'c01095f0f2480607c8313765e486333c42bfcfd0a4583c575ac366506b3a4fe1'
		API_URL = 'http://api.pachube.com/v2/feeds/%s.xml?key=%s'

	def calcGeoDist( self, lat1, lon1 , lat2, lon2 ):
		nauticalMilePerLat = 60.00721
		nauticalMilePerLongitude = 60.10793
		rad = math.pi / 180.0
		milesPerNauticalMile = 1.15078
		yDistance = (lat2 - lat1) * nauticalMilePerLat
		xDistance = (math.cos(lat1 * rad) + math.cos(lat2 * rad)) * (lon2 - lon1) * (nauticalMilePerLongitude / 2)
		distance = math.sqrt( yDistance**2 + xDistance**2 )
		return distance * milesPerNauticalMile

	#	http://api.pachube.com/v2/feeds/14567.xml?key=c01095f0f2480607c8313765e486333c42bfcfd0a4583c575ac366506b3a4fe1
	def getFeed( self ):
		url = API_URL % (self.feed_id, API_KEY)
		print url
		try:
			#path = urllib2.urlopen( url )
			dom = minidom.parse( urllib2.urlopen( url ) )
			#print path.read()
			return dom
		except Exception, e:
			tb = sys.exc_info()[2]
	 		traceback.print_exception(e.__class__, e, tb)		
			print "Ya, sorry. No dom."
			return None

	#############
	# eeml -> location -> lat
	# eeml -> location -> lon
	# eeml -> data[3] -> current_value (Last Port)
	# eeml -> data[4] -> current_value (Destination)
	#############
	def curPosition( self,feed ):
	#	pass
		if feed != None:
			try:
				loc = feed.getElementsByTagName('location')[0]
				x = loc.getElementsByTagName('lat')[0].firstChild.nodeValue
				y = loc.getElementsByTagName('lon')[0].firstChild.nodeValue
				print x
				print y
				return ( float(x), float(y) )
			except Exception, e:
				tb = sys.exc_info()[2]
				traceback.print_exception(e.__class__, e, tb)
				print "Ya, sorry. No dom."
		else:
			print "Ya, sorry. No dom."
			return None
			
			
	
if __name__ == '__main__':  
	try:
		r = Run()
		r.main()
	except Exception, e:
		tb = sys.exc_info()[2]
 		traceback.print_exception(e.__class__, e, tb)