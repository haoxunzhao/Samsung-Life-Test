import json
import sqlite3 as sqlite

DBNAME = 'LifeTimeDB.db'
try:
    conn = sqlite.connect(DBNAME)
    cur = conn.cursor()
except Error as e:
    print(e)

data = {}
statement = 'SELECT * FROM Model'
model = cur.execute(statement).fetchall()
statement = 'SELECT * FROM Week'
week = cur.execute(statement).fetchall()

for i in model:
    data[i[1]] = {}
    for j in week:
        data[i[1]][j[1]] = []
        statement = 'SELECT * FROM WeeklySales WHERE WeekId="'
        statement += str(j[0])+'" AND ModelId="'+str(i[0])+'"'
        res = cur.execute(statement).fetchall()
        if len(res) == 1 and res[0][3] > 300 :
            statement = 'SELECT * FROM Failure WHERE WeekId="'
            statement += str(j[0])+'" AND ModelId="'+str(i[0])+'" ORDER BY UsingTime ASC'
            res1 = cur.execute(statement).fetchall()
            if len(res1) != 0 :
                total = res[0][3]
                cumulation = 1
                for k in res1:
                    current = round((total-1)/total,7)
                    cumulation *= current
                    data[i[1]][j[1]].append([k[3],k[4],k[5],total,current,cumulation])
                    total -= 1
                    if total == 0 :
                        print(i,j)
                        print('************')
                        break

f = open('dataset.json','w',encoding = 'utf-8')
f.write(json.dumps(data, indent=4))
f.close()
