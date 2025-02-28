import random

description = "이 모듈은 테스트를 위해 만들었습니다."

def greetings(name):
    return f'{name}님 반갑습니다.'

def select_rand_number(cnt=1):    
    return [random.random() for _ in range(cnt)]


print(__name__) # __name__ : import로 실행하면 모듈의 이름 출력. python 명령으로 실행하면 "__main__" 출력

if __name__ == "__main__":
    r = greetings("John Doe")
    print(r)
    r = select_rand_number(5)
    print(r)