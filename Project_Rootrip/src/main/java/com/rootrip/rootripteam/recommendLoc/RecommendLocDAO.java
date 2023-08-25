package com.rootrip.rootripteam.recommendLoc;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Map.Entry;

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
			
			// 빈 리스트 생성
			List<BigDecimal> locs = new ArrayList<BigDecimal>();
			// 빈 해쉬맵 생성(지역 - 갯수)
			HashMap<BigDecimal, Integer> map = new HashMap<BigDecimal, Integer>();
			
			System.out.println(acts.get(0));
			
			try {
				// 액티비티 중 첫번째 인덱스를 할 수 있는 지역들 불러오기
				locs = ss.getMapper(RecommendLocMapper.class).getLocByCate(acts.get(0));
				// 
				Set<BigDecimal> set = new HashSet<BigDecimal>(locs);
				for (BigDecimal s : set) {
					System.out.println(s + ":" + Collections.frequency(locs, s));
					map.put(s, Collections.frequency(locs, s));
				}
				for(Entry<BigDecimal, Integer> entry : map.entrySet()) {
					System.out.println("[key]" + entry.getKey() + "[value]" + entry.getValue());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
