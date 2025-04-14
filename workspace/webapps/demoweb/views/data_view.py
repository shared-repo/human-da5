from flask import Blueprint
from flask import render_template, redirect, url_for
from flask import request

import os
import math
from pathlib import Path

import pandas as pd

from ..db import data_util

data_bp = Blueprint('data', __name__, url_prefix="/data")

@data_bp.route('/init-titanic', methods=['GET'])
def init_titanic():
    # 파일에서 데이터 읽기
    bp_path = data_bp.root_path # 현재 blueprint의 경로 ( 여기서는 views )
    root_path = Path(bp_path).parent #  부모 경로 (여기서는 demoweb )
    file_path = os.path.join(root_path, 'data_files', 'titanic-train.csv')
    df_titanic = pd.read_csv(file_path)

    df_titanic['Age'] = df_titanic['Age'].fillna(df_titanic['Age'].mean())
    df_titanic['Cabin'] = df_titanic['Cabin'].fillna('')
    df_titanic['Embarked'] = df_titanic['Embarked'].fillna('')

    # 데이터베이스의 titanic 테이블 초기화
    data_util.create_titanic_table()
    data = df_titanic.values.tolist() # pymysql ... executemany가 list, tuple 만 처리
    data_util.insert_titanic_data(data)

    # 응답컨텐츠 생산 --> home으로 이동
    return redirect(url_for('main.index'))

@data_bp.route('/titanic', methods=['GET'])
def titanic():
    # 파일에서 데이터 읽기
    # bp_path = data_bp.root_path # 현재 blueprint의 경로 ( 여기서는 views )
    # root_path = Path(bp_path).parent #  부모 경로 (여기서는 demoweb )
    # file_path = os.path.join(root_path, 'data_files', 'titanic-train.csv')
    # df_titanic = pd.read_csv(file_path)

    # 데이터베이스에서 데이터 읽기
    rows = data_util.select_titanic()
    df_titanic = pd.DataFrame(rows, columns=['PassengerId','Survived','Pclass','Name','Sex','Age','SibSp','Parch','Ticket','Fare','Cabin','Embarked'])

    # 템플릿으로 이동 ( 위에서 읽은 데이터 전달 )
    return render_template('data/titanic.html', df=df_titanic)


@data_bp.route('/titanic-by-page', methods=['GET'])
def titanic_by_page():

    # 요청 데이터 읽기 ( 페이지 번호 읽기 )
    page_no = request.args.get('page_no', '1')
    page_no = int(page_no)

    pager = {
        "page_no" : page_no,
        "page_size" :  10, # 한 페이지에 표시할 행의 수
        "pager_size" : 5 # 페이지 번호 표시 갯수
    }
    
    data_cnt = data_util.select_titanic_count() # 전체 데이터 갯수

    pager['page_cnt'] = math.ceil(data_cnt / pager['page_size']) # 나눗셈 + 올림
    pager['page_start'] = ( (pager['page_no'] - 1) // pager['pager_size'] ) * pager['pager_size'] + 1
    pager['pager_stop'] = pager['pager_start'] + pager['pager_size']

    page_start = (page_no - 1) * 10 # 현재 페이지에서 보여줄 데이터의 시작 번호

    # 데이터베이스에서 해당 페이지의 데이터 읽기
    rows = data_util.select_titanic_by_page(page_start, pager['page_size'])
    df_titanic = pd.DataFrame(rows, columns=['PassengerId','Survived','Pclass','Name','Sex','Age','SibSp','Parch','Ticket','Fare','Cabin','Embarked'])

    # 템플릿으로 이동 ( 위에서 읽은 데이터 전달 )
    return render_template('data/titanic_by_page.html', df=df_titanic, pager=pager)
