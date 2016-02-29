#-*-coding:utf8-*-
"""
    Carriots.com
    Created 29 Feb 2016
"""

import RPi.GPIO as GPIO
import json
from time import sleep
from Carriots import Carriots

def main():
    GPIO.setmode(GPIO.BCM)
    
    GPIOLed = 23
    GPIO.setup(GPIOLed, GPIO.OUT)
    GPIO.output(GPIOLed, GPIO.LOW)

    # Parameters at Carriots
    device = "YOUR DEVICE's ID_DEVELOPER HERE"  # Replace with the id_developer of your device
    apikey = "YOUR APIKEY HERE"                 # Replace with your Carriots apikey

    # Object instance of Carriots
    carriots = Carriots(apikey)
    
    led_history = None

    # The loop routine runs over and  over again forever
    while True:

        device_json = carriots.get(device)
        device_carriots = json.loads(device_json.read())

        led_value = device_carriots["properties"]["value"]

        if led_value != led_history:
            led_history = led_value

            print "Status: Led " + led_value

        if led_value == "ON":
            GPIO.output(GPIOLed, GPIO.HIGH)
        elif led_value == "OFF":
            GPIO.output(GPIOLed, GPIO.LOW)
        elif led_value == "BLINK":
            GPIO.output(GPIOLed, GPIO.HIGH)
            sleep(1)
            GPIO.output(GPIOLed, GPIO.LOW)
            sleep(1)

if __name__ == '__main__':
    main()
