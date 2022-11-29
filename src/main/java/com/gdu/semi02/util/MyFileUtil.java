package com.gdu.semi02.util;

import java.io.File;
import java.util.Calendar;
import java.util.UUID;
import java.util.regex.Matcher;

import org.springframework.stereotype.Component;

@Component
public class MyFileUtil {
	
	// 파일명 : UUID(Universal Unique ID) 값을 사용 (Java에서 지원되고 있음)
	// 경로명 : 현재 날짜를 Directory로 생성해서 사용(매일매일 폴더가 새로 생성)
	
	public String getFilename(String filename) {
		
		// 확장자 예외처리
		String extension = null;
		if(filename.endsWith("tar.gz")) { // 파일이름이 ~로 끝난다.
			extension = "tar.gz"; // 어떤 확장자들이 있는지는 더 찾아보기
		} else if(filename.endsWith("tar.bz2")){
			extension = "tar.bz2"; // 어떤 확장자들이 있는지는 더 찾아보기
		} else {
			// 파라미터로 전달된 filename의 확장자만 살려서 UUID.확장자 방식으로 반환(기존 파일이름은 갖다버릴거임. Unique처리를 위해서)
			// ▼ 여러가지 장점이 있음. ▼
			// 1. Unique처리를 할 수 있다. 수많은 사용자가 똑같은 파일을 올리지 않을 거란 보장이없으니
			// 2. UUID값으로 처리하면 한글이 없으니 인코딩이 필요없다.
			// 확장자를 기준으로 이름 자르기
			String[] arr = filename.split("\\."); // 마침표가 있으면 파일이름을 다 잘라주시오 (여러번 다 가능) Java에서는 \\라고하면 \이다.
			// split은 정규식을 받아온다 정규식에서의 마침표(.)는 모든문자로 인식하기 때문에 \.을 이용하여 모든문자가 아닌 마침표로 인식하라는 의미
			// [.] 또는 \. 을 이용하면 된다.
			
			// 확장자
			extension = arr[arr.length-1]; // Linux의 확장자는 압축파일은 압축의 종류에 따라 .tar.gz 이런식으로 계속 추가되므로 		
		}
		
		// UUID.확장자(UUID는 뭐 나올지 모름 UUID는 ______-______-______형식으로 나옴) 16진수로 만들어줌. 
		// 하이픈도 삭제해주기 위해 toString()을 이용하여 String Type으로 변경. replaceAll을 이용하여 하이픈 없애주었음.
		return UUID.randomUUID().toString().replaceAll("\\-", "") + "." + extension ;
	}
	
	// 오늘 경로
	public String getTodayPath() {
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1; // 0~11
		int day = calendar.get(Calendar.DAY_OF_MONTH); // 11월달의 21일
		String sep = Matcher.quoteReplacement(File.separator); // Matcher는 값을 넘길 때 안깨지게 하는 것 (File.separator는 파일 경로를 표시하는 \나 /를 자동으로 넣어주는애)
		return "storage" + sep + year + sep + makeZero(month) + sep + makeZero(day);
	}
	
	// 어제 경로
		public String getYesterdayPath() {
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -1); // 1일 전 (단위는 Date, 값은 -1)
			int year = calendar.get(Calendar.YEAR);
			int month = calendar.get(Calendar.MONTH) + 1; // 0~11
			int day = calendar.get(Calendar.DAY_OF_MONTH); // 11월달의 21일
			String sep = Matcher.quoteReplacement(File.separator); // Matcher는 값을 넘길 때 안깨지게 하는 것 (File.separator는 파일 경로를 표시하는 \나 /를 자동으로 넣어주는애)
			return "storage" + sep + year + sep + makeZero(month) + sep + makeZero(day);
		}
		
		// 1~9 => 01~09
		public String makeZero(int n) {
			return (n < 10 ? "0" + n : "" + n);
		}
	
}