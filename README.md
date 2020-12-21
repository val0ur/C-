# C# project ON

C# chart with SQLite data
> https://stackoverflow.com/questions/62995945/c-sharp-chart-with-sqlite-data


# SQLite3 다운로드
http://system.data.sqlite.org 에서 .Net 버전에 맞게 다운로드 

# Visual Studio Nuget 이용
1. 프로젝트 생성
2. 누겟 패키지 관리자에서 system.Data.SQLite 패키지 설치 


#SQLite 시간대별 

strftime(format, timestring, modifier, modifier, ...)
//strftime 함수는 형식을 직접 지정한다. 

SELECT * FROM table WHERE strftime('%s', date) BETWEEN sttftime('%s', start_date) AND strftime('%s', end_date)

SELECT * FROM 테이블명 WHERE 조건명 BETWEEN "2020-01-01" AND "20202-01-02"




