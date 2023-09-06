package com.rootrip.rootripteam.recommendLoc;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecommendLocDAO {
	
	public void name() {
		
	}
	
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
			
			List<BigDecimal> acts = new ArrayList<BigDecimal>();
			List<BigDecimal> others = new ArrayList<BigDecimal>();
//			ArrayList<BigDecimal> quiets = new ArrayList<BigDecimal>();
//			ArrayList<BigDecimal> tours = new ArrayList<BigDecimal>();
//			ArrayList<BigDecimal> tastes = new ArrayList<BigDecimal>();
			
			for (String q : arrQ4) {
				catNum = Integer.parseInt(q);
				
				if (catNum/100 == 4) { // 4xx : 액티비티
					acts.add(new BigDecimal(q));
				} else {
					others.add(new BigDecimal(q));
				}
//				else if (catNum/100 == 3) { // 3xx : 휴양 
//					quiets.add(new BigDecimal(q));
//				} else if (catNum/100 == 2) { // 2xx : 관광
//					tours.add(new BigDecimal(q));
//				} else { // 1xx : 맛집
//					tastes.add(new BigDecimal(q));
//				}
			}
			
			
			// 4xx 할 수 있는 지역 찾기
			
			// 빈 액티비티 리스트 생성
			List<BigDecimal> locs = new ArrayList<BigDecimal>();
			
			// 빈 카테고리 리스트
			List<BigDecimal> cats = new ArrayList<BigDecimal>();
			
			// 빈 맵 생성(지역 - 일치 갯수)
			final Map<BigDecimal, Integer> map = new HashMap<BigDecimal, Integer>();
			// 정렬 후 리스트
			List<BigDecimal> keySet;
			// 지역 이름 순위 리스트
			List<String> locNames;
			// 결과 리스트
			List<List<String>> resultList = new ArrayList<List<String>>();
			
			
			if ( acts.size() != 0 ) { // 액티비티를 선택했다면
				try {
					for (int i = 0; i < acts.size(); i++) {
						
						// 액티비티 중 첫번째 인덱스를 할 수 있는 지역들 불러오기
						locs = ss.getMapper(RecommendLocMapper.class).getLocByCate(acts.get(i));
						
						// 지역마다 할 수 있는 카테고리 리스트(4xx 제외) 조회
						for (BigDecimal l : locs) {
							cats = ss.getMapper(RecommendLocMapper.class).getCateByLoc(l);
							// others와 cats를 비교하여 중복 값 찾기(갯수찾기)
							cats.retainAll(others);
							// 맵에 넣기
							map.put(l, cats.size());
							}
						
						// 지역별 카테고리 리스트
						keySet = new ArrayList<BigDecimal>(map.keySet());
						
						// value 에 따라 keyset 내림차순 정렬
						keySet.sort(new Comparator<BigDecimal>() {
							@Override
							public int compare(BigDecimal o1, BigDecimal o2) {
								return map.get(o2).compareTo(map.get(o1));
							}
						});
						
						// 지역 이름을 담을 새로운 리스트 생성
						locNames= new ArrayList<String>();
						
						// 카테고리 이름도 가져오기
						locNames.add(ss.getMapper(RecommendLocMapper.class).getCatName(acts.get(i)));
						
						// ketset(지역코드)에 따라 지역 이름 조회 후 locNames에 추가
						for (BigDecimal key : keySet) {
							locNames.add(ss.getMapper(RecommendLocMapper.class).getLocName(key));
						}
						resultList.add(locNames);
						
					}
					req.setAttribute("resultList", resultList);
					
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			
			} else { // 액티비티를 선택하지 않았다면
				try {
					locs = ss.getMapper(RecommendLocMapper.class).getAllLoc();
					// 지역마다 할 수 있는 카테고리 리스트(4xx 제외) 조회
					for (BigDecimal l : locs) {
						cats = ss.getMapper(RecommendLocMapper.class).getCateByLoc(l);
						// others와 cats를 비교하여 중복 값 찾기(갯수찾기)
						cats.retainAll(others);
						// 맵에 넣기
						map.put(l, cats.size());
					}
					// 지역별 카테고리 리스트
					keySet = new ArrayList<BigDecimal>(map.keySet());
					
					// value 에 따라 keyset 내림차순 정렬
					keySet.sort(new Comparator<BigDecimal>() {
						@Override
						public int compare(BigDecimal o1, BigDecimal o2) {
							return map.get(o2).compareTo(map.get(o1));
						}
					});
					
					// 지역 이름을 담을 새로운 리스트 생성
					locNames= new ArrayList<String>();
					
//					int mapVal = map.get(keySet.get(0));
//					System.out.println(mapVal);
//					int count = 0;
					// ketset(지역코드)에 따라 지역 이름 조회 후 locNames에 추가
					for (BigDecimal key : keySet) {
//						System.out.println(key + ":" + map.get(key));
						locNames.add(ss.getMapper(RecommendLocMapper.class).getLocName(key));
					}
					
					req.setAttribute("resultListNoActs", locNames);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
