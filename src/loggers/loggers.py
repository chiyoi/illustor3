import sys


class Logger:
    prefix: str

    def __init__(self):
        self.prefix = ""
        return

    def Println(self, msg: str):
        print(self.prefix + msg)

    def Fatalln(self, msg: str):
        print(self.prefix + msg)
        sys.exit(1)
    
    def Panicln(self, msg: str):
        print(self.prefix + msg)
        raise AssertionError(msg)
