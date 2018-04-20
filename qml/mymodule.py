import os

def speak(text):
    print(text)
    return text +" returned from py module"


def listdir(cwd):
    return os.listdir(cwd)
