from collections import Counter
from pprint import pprint

def calc_max(dict):
    max = 0
    maxeye = None
    for key, value in dict.items():
        if max < value:
            max = value
            maxeye = key
    return {'maxeye': maxeye, 'max': max}

dice_file = open('applied12/IPrg12-dice.txt', 'r')
dice_Counter = Counter(map(int, dice_file.readlines()))
ans_dict = calc_max(dice_Counter)
pprint(dice_Counter, width=10)
pprint(ans_dict, width=10)