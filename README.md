# 아이디어

## anti forensics 이벤트가 발생했을 때 (Windows Event log code : 1100) 해당 시점 10분 전 후로 timline 항목과 installed program, 검색기록을 보여준다. 

### timeline은 opensource api를 활용한다. 
- timeline의 경우에는 해당 시간대에 일어난 일련의 전반적인 행위들을 보여줌으로써 수사관이 추적할 방향성을 제시해준다. 

### installed_program과 search terms는 .txt.로 입력받아서 wordcloud2 패키지 이용해서 이미지로 보여주고 
- 만약 악성 tool이 실행 후 실행 및 이후 로그들을 지우더라도 설치 기록을 통해서 유추가 가능할 것이다. 
- 마찬가지로 해당 악성행위 및 로그가 삭제 되더라도 이전의 검색 기록을 기반으로 유추가 가능하다. 



C#에서 R 실행하기 
--

1. Process로 직접 R.Test.R 실행시키기
  string RScriptPath = @"C:\Program Files\...\Rscript.exe";
  string RCodeFilePath=@"C:\RTest.R";
  
  Process StartInfo pstInfo = new ProcessStartInfo(RScriptPath, RCodeFilePath);
  pstInfo.UseShellExecute = false;
  pstInfo.RedirectStandardOutput = true;
  Process.Start(pstInfo);
  Console.WriteLine("R Done!!");


