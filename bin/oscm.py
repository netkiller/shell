#!/usr/bin/python3
# -*- encoding: utf-8 -*-

try:
    import os
    import sys
    import time
    import smtplib
    from email.message import EmailMessage
    from optparse import OptionParser, OptionGroup
    import dbm
    import hashlib
    import configparser
    import math
except ImportError:
    print('Python3 try again')
    exit()

class OSCM():
    debug = False
    db = {}
    path = None
    # os.path.expanduser('/Users/neo/Library/Mobile\ Documents//com~apple~CloudDocs/Book')
    books = []
    kindle = set()
    # extention='.mobi'



    def __init__(self):

        self.config = configparser.ConfigParser()
        self.config.read('config.ini')

        usage = "usage: %prog [option] list|install|remove app"
        self.parser = OptionParser(
            usage, version="%prog 1.0.0", description='OS configure management')

#        self.parser.add_option("-p", "--path", dest='path', default='Book',
#                               help="The path of library", metavar='/var/book/')
#        self.parser.add_option(
#            '-f', '--force', action="store_true", default=False, help="force sendmail")
#        self.parser.add_option("-b", "--book", dest='book', default=None,
#                               help="book path", metavar='/path/to/book.mobi')
#        self.parser.add_option("-g", "--group", dest='group', default='kindle',
#                               help="User group", metavar='{kindle|phone|ipad|email|other}')
#        self.parser.add_option('-a', '--all', action="store_true",
#                               default=False, help="Push all of books to friends")
#        self.parser.add_option('-n', '--netkiller', action="store_true",
#                               default=False, help="Push books to mine<netkiller@kindle.cn>")
#        self.parser.add_option('-e', '--ext', dest='ext', default='.mobi',
#                               help="file extention name, default: .mobi", metavar='{mobi|pdf}')
#
#        group = OptionGroup(self.parser, 'Database', '')
#        group.add_option('-l', '--library', dest='library',
#                         action="store_true", default=False, help="list library")
#        group.add_option('-u', '--user', action="store_true",
#                         default=False, help="list kindle users")
#        group.add_option('-s', '--bibliography', action="store_true",
#                         default=False, help="list the user's bibliography")
#        self.parser.add_option_group(group)
#
#        group = OptionGroup(self.parser, 'Advanced', '')
#        group.add_option('', '--upgrade', dest='upgrade', default='',
#                         help="smtp server default: msn", metavar='|'.join(self.config.sections()))
#        group.add_option('', '--size', dest='size', type='int',
#                         default=40, help="file size (MB)", metavar='40')
#        group.add_option('-k', '--azw3', action="store_true",
#                         default=False, help="azw3 file first")
#        group.add_option("-o", "--offset", dest='offset',
#                         default='0', help="Index offset number", metavar='10')
#        group.add_option("-D", "--date", dest='date', default=None,
#                         help="from date", metavar='2019-01-01')
#        self.parser.add_option_group(group)
#
#        self.parser.add_option(
#            '-d', '--debug', action="store_true", default=False, help="debug mode")

        (self.options, self.args) = self.parser.parse_args()

    def remove(self, app):
        pass
    def list(self):
        pass

    def install(self, app):
        pass

    def usage(self):
        self.parser.print_help()
        print("\n  Homepage: http://www.netkiller.cn Author: Neo <netkiller@msn.com>")
        sys.exit(1)

    def main(self):
        try:
            if self.debug:
                print("===================================")
                print(self.options, self.args)
                print("===================================")
                print(self.db)
                print("===================================")
#                for item in self.config[self.options.smtp]:
#                    print(item + '='+self.config.get(self.options.smtp, item))
                    
            

#            if self.options.path:
#                self.path = self.options.path
#
#            if self.options.group:
#                self.group = 'db/'+self.options.group
#
#            if self.options.library:
#                self.library()
#                exit()
#            elif self.options.user:
#                self.userlist()
#                exit()
#
            if self.args and self.args[0].lower() in ('list','install','remove'):
                print(self.args[0].lower())
                if self.args[0].lower() == 'list':
                    print("aaaaa")
                if self.args[0].lower() == 'install':
                    print("aaaaa")
                else:
                    self.parser.error("option requires an argument")
            else:
                
                self.usage()

        except Exception as err:
            print("Error: %s %s" % (err, self.__class__.__name__))
            sys.exit(1)


if __name__ == '__main__':
    try:
        oscm = OSCM()
        oscm.debug = True
        oscm.main()
    except KeyboardInterrupt:
        print("Crtl+C Pressed. Shutting down.")
