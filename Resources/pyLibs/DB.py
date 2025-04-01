import pymssql
from robot.api.deco import keyword


class MySQLdb:
    cursors = None


class DB:
    conn = None
    def __init__(self, DBHost, DBUser, DBPass, DBName, sqlQuery):
        self.DBHost = DBHost
        self.DBUser = DBUser
        self.DBPass = DBPass
        self.DBName = DBName
        self.sqlQuery = sqlQuery
    @keyword("connectDB")
    def connectDB(self):
        self.conn = pymssql.connect('hostname', 'user', '*****', 'some_table', cursorclass=MySQLdb.cursors.SSCursor)

    @keyword("executeQuery")
    def query(self, sql):
        try:
            cursor = self.conn.cursor()
            cursor.execute(sql)
        except (AttributeError, pymssql.OperationalError):
            self.connect()
            cursor = self.conn.cursor()
            cursor.execute(sql)
        return cursor