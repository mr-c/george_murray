'''#l = [1,2,3,4,5]

#print(l)

#l[1]=99

game = [[0, 0, 0,],
        [0, 0, 0,],
        [0, 0, 0,],]

game = "I want to play a game"
print(id(game))

def game_board(player = 0, row = 0, column = 0, just_display = False):
    global game
    game = "A game"
    print(id(game))
    print(game)

print(game)
game_board()
print(game)
print(id(game))
'''


game = [[0, 0, 0,],
        [0, 0, 0,],
        [0, 0, 0,],]

def game_board(game_map, player = 0, row = 0, column = 0, just_display = False):
    print("   a  b  c")
    if not just display:
        game[row][column] = player
    for count, row in enumerate(game):
        print(count, row)

    return game_map

game = game_board(game, just_display=True)
game = game_board(game, player = 1, row = 2,  column = 1)
#game[0][1] = 1
#game_board()


  #for item in row: 
        #print(item)
      