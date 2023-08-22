package com.rootrip.rootripteam.recommendLoc;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

@Service
public class RecommendLocDAO {
	public void getResult(HttpServletRequest req) {
		try {
			// 파라미터값 가져오기
			String Q4 = req.getParameter("Q4");
			
			// Q4 , 기준으로 자르기
			String arrQ4[] = Q4.split(",");
			
			// 반복문 돌려서 분류하기 
			int a = 0;
			
			ArrayList<String> acts = new ArrayList<String>();
			ArrayList<String> quiets = new ArrayList<String>();
			ArrayList<String> tours = new ArrayList<String>();
			ArrayList<String> tastes = new ArrayList<String>();
			
			for (String q : arrQ4) {
				a = Integer.parseInt(q);
				
				if (a/100 == 4) { // 4xx : 액티비티
					acts.add(q);
				} else if (a/100 == 3) { // 3xx : 휴양 
					quiets.add(q);
				} else if (a/100 == 2) { // 2xx : 관광
					tours.add(q);
				} else { // 1xx : 맛집
					tastes.add(q);
				}
			}
//			System.out.println("액티비티");
//			for (String s : acts) {
//				System.out.println(s);
//			}
//			System.out.println("============");
//			System.out.println("휴양");
//			for (String s : quiets) {
//				System.out.println(s);
//			}
//			System.out.println("============");
//			System.out.println("관광");
//			for (String s : tours) {
//				System.out.println(s);
//			}
//			System.out.println("============");
//			System.out.println("맛집");
//			for (String s : tastes) {
//				System.out.println(s);
//			}
//			System.out.println("============");
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
