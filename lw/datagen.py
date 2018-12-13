import random
goods = [8001, 8002, 8003, 8004, 8010, 8011, 8050, 8100, 8050, 8100, 8101, 8102, 8103, 8200, 8201, 8203, 8204]
for i in range(21, 31):
    amount_of_goods = random.randrange(1, 7)
    temp_goods = goods.copy()
    for j in range(amount_of_goods):
        item = random.choice(temp_goods)
        temp_goods.remove(item)
        amount = random.randint(1, 20)
        print(i, " ", item, " ", amount)
        input()
        
# months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
# years = [2010, 2011]
# days = []
# hours = []
# minutes = []
# cashiers = [1000, 1200, 1001, 1020, 1009, 1051]
# casboxes = [100, 101, 103, 200, 201, 203]
# for i in range(12 + 1):#hours
#     if 1 <= i <= 9:
#         hours.append("0" + str(i))
#     else:
#         hours.append(i)
#
#
# for i in range(1, 61):#minutes
#     if 1 <= i <= 9:
#         minutes.append("0" + str(i))
#     else:
#         minutes.append(i)
#
# for i in range(1, 31):#days
#     if 1 <= i <= 9:
#         days.append("0" + str(i))
#     else:
#         days.append(str(i))
#
# checks = 20
# for i in range(checks + 1):
#     print(random.choice(months), " ", random.choice(days), " ", random.choice(years), " ", random.choice(hours), " ", random.choice(minutes), " ", random.choice(minutes), " ", random.choice(["AM","PM"]),
#     " ", random.choice(cashiers), " ", random.choice(casboxes))
#     input()
