import RPi.GPIO as GPIO


if __name__ == '__main__':

  GPIO.setmode(GPIO.BCM)
  GPIO.setwarnings(False)
  GPIO.setup(18,GPIO.OUT)

  #print "LED on"
  GPIO.output(18,GPIO.LOW)

