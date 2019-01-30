import json
import xlrd
import xlwt

f = open('dataset.json','r')
data = json.load(f)
f.close()

workbook = xlwt.Workbook(encoding = 'utf-8')
worksheet = workbook.add_sheet('FailureGroup')
row = 0
col = 0
try:
    for i in data:
        for j in data[i]:
            if data[i][j] != []:
                worksheet.write(row, col, label = i)
                worksheet.write(row, col+1, label = j)
                row += 1
                for k in data[i][j]:
                    for l in k:
                        worksheet.write(row, col, label = l)
                        col += 1
                    row += 1
                    col -= 6
                row += 2
        row = 0
        col += 8
except:
    print(i,j)
workbook.save('LifeTime.xls')
