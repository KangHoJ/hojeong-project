board = [[0,0,0,0,0],[0,0,1,0,3],[0,2,5,0,1],[4,2,4,4,2],[3,5,1,3,1]]
moves = [1,5,3,5,1,2,1,4]

cnt = 0
stack =[]
for i in moves:
    for j in range(5):
        if len(stack)>2 and (stack[-1] == stack[-2]):
            del stack[-2:] # 들어온값이랑 같은거 두개 제거 
            cnt +=2
        if board[j][i-1] ==0:
            continue
        elif board[j][i-1] !=0:
            stack.append(board[j][i-1])
            board[j][i-1] == 0
            break
        
        
    print(f'after: {stack}')

            