game_size = 5
'''
game = []

for i in range(game_size):
    row = []
    for i in range(game_size):
        row.append(0)
    game.append(row)
'''

game_size = input("What size game of tic tac toe? " )
game = [[0 for i in range(game_size)] for i in range(game_size)]
print(game)









'''import itertools

player_choice = itertools.cycle([1, 2])

for i in range(10):
    print(next(player_choice))
'''

'''players = [1, 0]

choice = 1
for i in range(10):
    current_player = choice+1
    print(current_player)
    choice = players[choice]
    

game_size = 3
print("   0  1  2")

s = "   "+"  ".join([str(i) for i in range(game_size)])

print(s)

dictionaries = {"key1":15, "key2":32}

print(dictionaries["key1"])

dictionaries["hithere"] = 92

print(dictionaries)


for i in range(game_size):
    s += "  "+str(i)

print(s)
'''