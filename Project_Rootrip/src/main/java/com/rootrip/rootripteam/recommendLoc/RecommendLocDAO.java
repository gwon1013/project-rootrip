package com.rootrip.rootripteam.recommendLoc;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecommendLocDAO {
	
	@Autowired
	private SqlSession ss;
	
	public void getResult(HttpServletRequest req) {
		try {
			// 파라미터값 가져오기
			String Q4 = req.getParameter("Q4");
			
			// Q4 , 기준으로 자르기
			String arrQ4[] = Q4.split(",");
			
			// 반복문 돌려서 분류하기 
			int catNum = 0;
			
			ArrayList<BigDecimal> acts = new ArrayList<BigDecimal>();
			ArrayList<BigDecimal> quiets = new ArrayList<BigDecimal>();
			ArrayList<BigDecimal> tours = new ArrayList<BigDecimal>();
			ArrayList<BigDecimal> tastes = new ArrayList<BigDecimal>();
			
			for (String q : arrQ4) {
				catNum = Integer.parseInt(q);
				
				if (catNum/100 == 4) { // 4xx : 액티비티
					acts.add(new BigDecimal(q));
				} else if (catNum/100 == 3) { // 3xx : 휴양 
					quiets.add(new BigDecimal(q));
				} else if (catNum/100 == 2) { // 2xx : 관광
					tours.add(new BigDecimal(q));
				} else { // 1xx : 맛집
					tastes.add(new BigDecimal(q));
				}
			}
			
			
			// 4xx 할 수 있는 지역 찾기
			for (BigDecimal a : acts) {
				System.out.println(a+"할 수 있는 곳");
				
				List<BigDecimal> locs = ss.getMapper(RecommendLocMapper.class).getLocByCate(a);
				for (BigDecimal l : locs) {
					System.out.println(l);
				}
				System.out.println("================");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
