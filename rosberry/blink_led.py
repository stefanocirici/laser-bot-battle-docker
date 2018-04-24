import RPi.GPIO as GPIO
import time
import signal


class GracefulKiller:
  kill_now = False
  def __init__(self):
    signal.signal(signal.SIGINT, self.exit_gracefully)
    signal.signal(signal.SIGTERM, self.exit_gracefully)

  def exit_gracefully(self,signum, frame):
    self.kill_now = True

if __name__ == '__main__':

  killer = GracefulKiller()

  GPIO.setmode(GPIO.BCM)
  GPIO.setwarnings(False)
  GPIO.setup(18,GPIO.OUT)

  while True:
    #print "LED off"
    GPIO.output(18,GPIO.HIGH)
    time.sleep(0.5)
    #print "LED on"
    GPIO.output(18,GPIO.LOW)
    time.sleep(0.5)

    if killer.kill_now:
      GPIO.output(18,GPIO.HIGH)
      break

#### error read from terminal when launching the image from rpi
Traceback (most recent call last):
  File "/blink_led.py", line 21, in <module>
    GPIO.setup(18,GPIO.OUT)
RuntimeError: No access to /dev/mem.  Try running as root!