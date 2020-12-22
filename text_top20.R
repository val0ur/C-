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



