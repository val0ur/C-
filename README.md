# 아이디어

## anti forensics 이벤트가 발생했을 때 (Windows Event log code : 1100) 해당 시점 10분 전 후로 timline 항목과 installed program, 검색기록을 보여준다. 

### timeline은 opensource api를 활용한다. 
- timeline의 경우에는 해당 시간대에 일어난 일련의 전반적인 행위들을 보여줌으로써 수사관이 추적할 방향성을 제시해준다. 

### installed_program과 search terms는 .txt.로 입력받아서 wordcloud2 패키지 이용해서 이미지로 보여주고 
- 만약 악성 tool이 실행 후 실행 및 이후 로그들을 지우더라도 설치 기록을 통해서 유추가 가능할 것이다. 
- 마찬가지로 해당 악성행위 및 로그가 삭제 되더라도 이전의 검색 기록을 기반으로 유추가 가능하다. 



C#에서 R 실행하기 
--

### 준비과정
https://bety.tistory.com/12


1. Process로 직접 R.Test.R 실행시키기

  string RScriptPath = @"C:\Program Files\...\Rscript.exe";

  string RCodeFilePath=@"C:\RTest.R";
  
  Process StartInfo pstInfo = new ProcessStartInfo(RScriptPath, RCodeFilePath);

  pstInfo.UseShellExecute = false;

  pstInfo.RedirectStandardOutput = true;

  Process.Start(pstInfo);

  Console.WriteLine("R Done!!");


[R] 영단어 데이터 전처리 및 빈도수 Top 20개 나열 
---


install.packages("tm")
library(tm)

sample <- scan("text.txt", what = "character")
source <- VectorSource(sample)

corpus <- Corpus(source)
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords("english")
corpus <- tm_map(corpus, removeWords, c("dont", "can","what", "cant"))
corpus <- tm_map(corpus, PlainTextDocument)

dtm <- DocumentTermMatrix(corpus)
dtm2 <- as.matrix(dtm)
frequency <- colSums(dtm2)
frequency <- sort(frequency, decreasing=T)
head(frequency)

sink("text_top20.txt")
frequency[1:20]
sink()

barplot(frequency[1:20], las =3)




install.packages("tm")					# tm 라이브러리 설치

library(tm)							# tm 라이브러리 실행



sample <- scan("text.txt", what="character")       # 분석하고자 하는 데이터 text.txt를 스캔하여 객체 sample로 저장

source <- VectorSource(sample)                   # 객체 sample을 벡터형으로 저장



corpus <- Corpus(source)                              # 벡터 형태로 저장된 source를 corpus화 시켜서 저장

corpus <- tm_map(corpus, tolower)                    # corpus를 전부 소문자로

corpus <- tm_map(corpus, removePunctuation)       # corpus의 punctuation 제거

corpus <- tm_map(corpus, stripWhitespace)          # corpus의 Whitespace 제거

corpus <- tm_map(corpus, removeWords, stopwords("english"))           # 특정 단어 제거 - 영어 불용어(stopwords)

corpus <- tm_map(corpus, removeWords, c("dont", "can", "what", "cant"))     # 특정 단어 제거 - 캐릭터 벡터로 지정

corpus <- tm_map(corpus, PlainTextDocument)



dtm <- DocumentTermMatrix(corpus)            # corpus를 dtm(문서->행, 용어->열)으로 변환 : 출현빈도 counting

dtm2 <- as.matrix(dtm)

frequency <- colSums(dtm2)

frequency <- sort(frequency, decreasing=T)    # frequency를 오름차순으로 정렬

head(frequency)                                   # frequency의 상위 6개 항목 출력



sink("text_top20.txt")  		                      # sink() 함수를 이용한 결과 txt 형식 저장 (시작)

frequency[1:20]                                    # frequency 형태로 저장한 corpus의 빈도 수 상위 100개 항목 출력

sink()						         # sink() 함수를 이용한 결과 txt 형식 저장 (종료)



barplot(frequency[1:20], las = 3)                  # 막대그래프 형태로 출력



출처: https://pannacotta.tistory.com/51 [Shimmering Green]

