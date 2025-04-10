from flask import Blueprint
from flask import render_template, redirect, url_for
from flask import request, session

from werkzeug.security import generate_password_hash, check_password_hash

from ..db import member_util

auth_bp = Blueprint("auth", __name__, url_prefix="/auth")

@auth_bp.route("/login/", methods=['GET', 'POST']) # 실제 경로 매핑 /auth/lgoin ( url_prefix와 결합 )
def login():
    if request.method.lower() == 'get':
        return render_template("auth/login.html")
    else:
        # 1. 요청 데이터 읽기
        email = request.form.get('email', '11')
        passwd = request.form.get('passwd', '22')
        remember = request.form.get('remember', '33')
        # return f'{email}, {passwd}, {remember}'

        # 2. 요청 처리
        row = member_util.select_member_by_email(email)        
        print(row)
        if not row: # 조회된 row가 없다면
            return render_template("auth/login.html", 
                                   message="존재하지 않는 아이디입니다.") # 템플릿(.html)에 전달되는 데이터

        # if email == 'iamuser@example.com' and passwd == '12345': # 로그인 성공
        if check_password_hash(row[1], passwd): # 로그인 성공
            session['loginuser'] = email # 로그인 처리 : 세션에 로그인 관련 데이터 저장
            # return render_template('index.html')
            return redirect(url_for('main.index')) # main blueprint의 index함수에 연결된 경로로 이동
        else:   # 로그인 실패
            # 3. 응답 컨텐츠 만들기
            return render_template("auth/login.html",
                                   message="패스워드를 확인하세요")
            # return redirect(url_for('auth.login'))


@auth_bp.route('/logout', methods=['GET'])
def logout():
    # del session['loginuser']  # session의 개별 데이터 제거
    # session['loginuser'] = None # session의 개별 데이터 제거
    session.clear() # session의 모든 데이터 제거

    return redirect(url_for('main.index'))


@auth_bp.route('/register', methods=['GET', 'POST'])
def register():
    if request.method.lower() == 'get':
        return render_template('auth/register.html')
    else:
        user_name = request.form.get('username')
        email = request.form.get('email')
        passwd = request.form.get('passwd')
        passwd_hash = generate_password_hash(passwd)        
        # return f'{user_name}, {email}, {passwd}'

        member_util.insert_member(email, passwd_hash, user_name)

        # return render_template('auth/login.html')
        return redirect(url_for('auth.login'))
