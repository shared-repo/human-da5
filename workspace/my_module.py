def greetings(name):
    return f'{name}님 반갑습니다.'

def select_rand_number(cnt=1):
    import random
    return [random.random() for _ in range(cnt)]