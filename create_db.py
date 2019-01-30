import xlrd
import xlwt
import sqlite3 as sqlite
def create_weeklysales():
    f = xlrd.open_workbook("test.xlsx")
    totalnum = {}
    table = f.sheets()[0]
    for i in range(table.nrows):
        if i == 0 or i == table.nrows-1:
            continue
        else:
            model = table.cell(i,0).value
            totalnum[model] = {}
        for j in range(table.ncols):
            if j==0 or j==1:
                continue
            else:
                week = table.cell(0,j).value
                totalnum[model][week] = table.cell(i,j).value

    DBNAME = 'LifeTimeDB.db'
    try:
        conn = sqlite.connect(DBNAME)
        cur = conn.cursor()
    except Error as e:
        print(e)
    statement ='DROP TABLE IF EXISTS "WeeklySales"'
    cur.execute(statement)
    conn.commit()
    statement = 'SELECT * FROM Model'
    res = cur.execute(statement).fetchall()
    modeldict = {}
    for i in res:
        modeldict[i[1]] = i[0]
    statement = 'SELECT * FROM Week'
    res = cur.execute(statement).fetchall()
    weekdict = {}
    for i in res:
        weekdict[i[1]] = i[0]

    statement = '''
        CREATE TABLE 'WeeklySales' (
        'Id' INTEGER PRIMARY KEY AUTOINCREMENT,
        'ModelId' INTEGER,
        'WeekId' INTEGER,
        'Quantity' INTEGER
        )
        '''
    cur.execute(statement)
    conn.commit()
    statement = 'INSERT INTO WeeklySales VALUES (?,?,?,?)'
    for i in totalnum:
        for j in totalnum[i]:
            vals = (None, modeldict[i], weekdict[j], totalnum[i][j])
            cur.execute(statement,vals)
            conn.commit()

def create_model_week():
    DBNAME = 'LifeTimeDB.db'
    try:
        conn = sqlite.connect(DBNAME)
        cur = conn.cursor()
    except Error as e:
        print(e)
    statement ='DROP TABLE IF EXISTS "Model"'
    cur.execute(statement)
    conn.commit()
    statement ='DROP TABLE IF EXISTS "Week"'
    cur.execute(statement)
    conn.commit()
    statement = '''
        CREATE TABLE 'Model' (
        'Id' INTEGER PRIMARY KEY AUTOINCREMENT,
        'ModelCode' TEXT
        )
        '''
    cur.execute(statement)
    conn.commit()
    statement = '''
        CREATE TABLE 'Week' (
        'Id' INTEGER PRIMARY KEY AUTOINCREMENT,
        'WeekCode' INTEGER,
        'Date' REAL
        )
        '''
    cur.execute(statement)
    conn.commit()
    f1 = xlrd.open_workbook('Week.xlsx')
    table = f1.sheets()[0]
    statement = 'INSERT INTO Week VALUES (?,?,?)'
    for i in range(table.nrows):
        vals = (None, table.cell(i,0).value, table.cell(i,1).value)
        cur.execute(statement,vals)
        conn.commit()

    f = xlrd.open_workbook("test.xlsx")
    table = f.sheets()[0]
    model = table.col_values(0)
    statement = 'INSERT INTO Model VALUES (?,?)'
    for i in model[1:-1]:
        vals = (None, i)
        cur.execute(statement, vals)
        conn.commit()

def create_failure():

    DBNAME = 'LifeTimeDB.db'
    try:
        conn = sqlite.connect(DBNAME)
        cur = conn.cursor()
    except Error as e:
        print(e)
    statement ='DROP TABLE IF EXISTS "Failure"'
    cur.execute(statement)
    conn.commit()
    statement = '''
        CREATE TABLE 'Failure' (
        'Id' INTEGER PRIMARY KEY AUTOINCREMENT,
        'WeekId' INTEGER,
        'ShippingDate' TEXT,
        'FailDate' TEXT,
        'UsingTime' INTEGER,
        'ModelId' INTEGER
        )
        '''
    cur.execute(statement)
    conn.commit()
    statement = 'SELECT * FROM Model'
    res = cur.execute(statement).fetchall()
    modeldict = {}
    for i in res:
        modeldict[i[1]] = i[0]
    statement = 'SELECT * FROM Week'
    res = cur.execute(statement).fetchall()
    weekdict = {}
    for i in res:
        weekdict[i[1]] = i[0]

    statement = 'INSERT INTO Failure VALUES (?,?,?,?,?,?)'
    f = xlrd.open_workbook("modeldata.xlsm")
    table = f.sheets()[0]
    for i in range(1,table.nrows):
        if table.cell(i,5).value.lower() =='field':
            try:
                vals = (None, weekdict[table.cell(i,0).value], table.cell(i,1).value,
                table.cell(i,2).value, table.cell(i,3).value ,
                modeldict[table.cell(i,4).value])
                cur.execute(statement,vals)
                conn.commit()
            except:
                print(i)
                print('*********************')

create_failure()
