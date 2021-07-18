import sys
import os
import sqlite3
from util import Util
from time import gmtime, strftime


class Db(object):
    '''
    The Db performs database operations.
    '''


    def __init__(self):
        '''
        Constructor
        '''
        self.conn = sqlite3.connect('/home/dh_vhkapj/digitalnewsobserver.com/obsidian/dxmxr.db')
        self.logger = Util()

    def delete_articles(self):
        del_conn = self.conn.cursor()
        del_conn.execute("DELETE FROM NewsLinks")
        self.conn.commit()
        del_conn.close()


    def insert_article(self, pub_date, article_cat, link_url, link_title):

            try:

                cur = self.conn.cursor()
                cur.execute("INSERT INTO NewsLinks (linkCat,linkUrl,linkDate,articleTitle) VALUES ('{0}','{1}','{2}','{3}')".format(article_cat,link_url,pub_date,link_title))

            except sqlite3.Error as err:
                self.logger.log_op("There is an error in the db class inserting from insert_article().")
                self.logger.log_op(err)

            finally:
                self.conn.commit()
                cur.close()
        
