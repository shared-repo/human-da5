from flask import Blueprint
from flask import render_template, redirect, url_for
from flask import request, session

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
        if email == 'iamuser@example.com' and passwd == '12345': # 로그인 성공
            session['loginuser'] = email # 로그인 처리 : 세션에 로그인 관련 데이터 저장
            # return render_template('index.html')
            return redirect(url_for('main.index')) # main blueprint의 index함수에 연결된 경로로 이동
        else:   # 로그인 실패
            # 3. 응답 컨텐츠 만들기
            return render_template("auth/login.html")
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
        pass
