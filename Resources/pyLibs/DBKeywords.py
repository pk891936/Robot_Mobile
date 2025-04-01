import pymssql

DBHost = "ircost.database.secure.windows.net:1433"
DBUser = "OrcaDevUser"
DBPass = "Orca1234"
DBName = "Integration-Orca"
sqlQuery = "select LicenseID from access_management.license where CustomerId = 330952 and CreditId='6F9B6D2A-4FEF-4BFD-9353-38077F5E8D33';"

class DBKeywords(DBHost, DBUser, DBPass, DBName, sqlQuery):

    def __init__(self, DBHost, DBUser, DBPass, DBName, sqlQuery):
        self.DBHost = DBHost
        self.DBUser = DBUser
        self.DBPass = DBPass
        self.DBName = DBName
        self.sqlQuery = sqlQuery
        self.conn = pymssql.connect(DBHost, DBUser, DBPass, DBName)
        self.cursor = self.conn.cursor()

    def executeQuery(self):
        self.cursor.execute(self.sqlQuery)
        for row in self.cursor:
            print('row = %r' % (row,))


    def __del__(self):
        self.conn.close()
        print("Disconnected {} Database".format(self.DBName))