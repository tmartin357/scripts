#!/usr/bin/env python

import sys
import os
import getopt
import datetime
import subprocess

JOB_NUM = int((datetime.datetime.now()-datetime.datetime(1970,1,1)).total_seconds())

def usage():
  print "usage: "+os.path.basename(sys.argv[0])+" TODO "

def validate_fname(fname):
  print "Output to: "+fname
  if os.path.isfile(fname):
    print "Error: file "+fname+" exists."
    sys.exit(2)

def scan(mode, dpi, debug):
  print mode, dpi, debug
  FNULL = open(os.devnull, 'w')
  
  if debug: 
    FNULL = subprocess.STDOUT

  #scanimage --batch=/tmp/123456%04d.pnm --source ADF -x 215.9 -y 279.4 --mode color --resolution 150  
  returncode = subprocess.call(["scanimage", "--batch=/tmp/"+str(JOB_NUM)+"%04d.pnm --source ADF -x 215.9 -y 279.4 --mode "+mode+" --resolution "+str(dpi)], stderr=FNULL)
  
  return returncode

def main(argv):
  mode = "color"
  dpi = 150
  ocr = False
  debug = False

  try:
    opts, args = getopt.getopt(argv, "hc:d:o", ["help", "mode=", "dpi=", "ocr", "debug"])
  except getopt.GetoptError:
    usage()
    sys.exit(1)

  for opt, arg in opts:
    if opt in ("-h", "--help"):
      usage()                     
      sys.exit()
    elif opt in ("-m", "--mode"):
      mode = arg
    elif opt in ("-d", "--dpi"):
      dpi = arg
    elif opt in ("-o", "--ocr"):
      ocr = True
    elif opt == "--debug":
      debug = True

  if scan(mode, dpi, debug) != 0:
    print "Error Scanning"
    sys.exit(1)

if __name__ == "__main__":
  validate_fname(sys.argv[-1])
  main(sys.argv[1:-1])
