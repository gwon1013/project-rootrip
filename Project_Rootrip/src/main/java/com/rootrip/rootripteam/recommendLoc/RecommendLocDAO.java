package com.rootrip.rootripteam.recommendLoc;

import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rootrip.rootripteam.location.LocationMapper;

@Service
public class RecommendLocDAO {
	
	
	
	@Autowired
	private SqlSession ss;
	
	@SuppressWarnings("unlikely-arg-type")
	public void recommendCourse(HttpServletRequest req) {
		// 지역 번호 파라미터
		BigDecimal l_no = new BigDecimal(req.getParameter("l_no"));
		
		// 날짜 파라미터
		String when = req.getParameter("when");
		String sDate = when.split(",")[0];
		String eDate = when.split(",")[1];
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date sDay = sdf.parse(sDate);
			Date eDay = sdf.parse(eDate);
			// 날짜간 차이 구하기
			long dif = (eDay.getTime() - sDay.getTime()) / (24*60*60*1000);
			
			// 여행기간
			long term = dif+1;
			
		
			// 카테고리 파라미터
			String cats = req.getParameter("cats");
			// 사용자가 고른 카테고리들
			String arrCat[] = cats.split(",");
			// 빈 사용자 카테고리 리스트
			List<BigDecimal> userCats = new ArrayList<BigDecimal>();
			// 형변환
			for (String c : arrCat) {
				userCats.add(new BigDecimal(c));
			}
			
			// 이 지역에서 할 수 있는 카테고리들
			List<BigDecimal> locCats = new ArrayList<BigDecimal>(ss.getMapper(RecommendLocMapper.class).getCateByLoca(l_no));
			// 사용자 카테고리와 지역 카테고리 중 중복값
			locCats.retainAll(userCats);
			
			// 중복된 값을 분류
			int catNum = 0;
			
			List<BigDecimal> acts = new ArrayList<BigDecimal>();
			List<BigDecimal> others = new ArrayList<BigDecimal>();
			List<BigDecimal> tastes = new ArrayList<BigDecimal>();
			
			for (BigDecimal q : locCats) {
				catNum = q.intValue();
				
				if (catNum/100 == 4) { // 4xx : 액티비티
					acts.add(q);
				} else if(catNum / 100 == 1){ // 맛집
					tastes.add(q);
				} else { // 그 외 활동들
					others.add(q);
				}
			}
			System.out.println(others);
			Random r = new Random();
			
			// 장소 배열(전체 장소)
			List<BigDecimal> allSpot = new ArrayList<BigDecimal>();
			// 리스트 리스트(2차)
			List<List<BigDecimal>> arrSpots = new ArrayList<List<BigDecimal>>();

			// 여행 기간만큼 반복
			for (long i = 0; i < term ; i++) {
				// 장소 배열(날짜 마다 장소)
				List<BigDecimal> arrSpot = new ArrayList<BigDecimal>();
				if (i == 0) { // 첫날이라면
					if (acts.size() != 0) { // 액티비티 선택했는가?
						
						if (tastes.size() != 0) { // 맛집을 선택했는가?
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(101)));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, acts.get(0)));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, others.get(r.nextInt(others.size()))));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(101)));
							allSpot.addAll(arrSpot);
							arrSpots.add(arrSpot);
						} else { // 맛집 선택 x
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(104)));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, acts.get(0)));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, others.get(r.nextInt(others.size()))));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(104)));
							allSpot.addAll(arrSpot);
							arrSpots.add(arrSpot);
						}
					} else { // 액티비티를 선택하지 않았는가?
						if (tastes.size() != 0) { // 맛집을 선택했는가?
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(101)));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, others.get(r.nextInt(others.size()))));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, others.get(r.nextInt(others.size()))));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(101)));
							allSpot.addAll(arrSpot);
							arrSpots.add(arrSpot);
						} else { // 맛집 선택 x
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(104)));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, others.get(r.nextInt(others.size()))));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, others.get(r.nextInt(others.size()))));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(104)));
							allSpot.addAll(arrSpot);
							arrSpots.add(arrSpot);
						}
					}
				}else { // 첫날이 아니라면
					if (acts.size() != 0) { // 액티비티 선택했는가?
						
						if (tastes.size() != 0) { // 맛집을 선택했는가?
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(101)));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, acts.get(0)));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, others.get(r.nextInt(others.size()))));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(101)));
							allSpot.addAll(arrSpot);
							arrSpots.add(arrSpot);
						} else { // 맛집 선택 x
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(104)));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, acts.get(0)));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, others.get(r.nextInt(others.size()))));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(104)));
							allSpot.addAll(arrSpot);
							arrSpots.add(arrSpot);
						}
					} else { // 액티비티를 선택하지 않았는가?
						if (tastes.size() != 0) { // 맛집을 선택했는가?
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(101)));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, others.get(r.nextInt(others.size()))));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, others.get(r.nextInt(others.size()))));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(101)));
							allSpot.addAll(arrSpot);
							arrSpots.add(arrSpot);
						} else { // 맛집 선택 x
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(104)));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, others.get(r.nextInt(others.size()))));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, others.get(r.nextInt(others.size()))));
								arrSpot.add(ss.getMapper(RecommendLocMapper.class).getRandomSpot(l_no, new BigDecimal(104)));
							allSpot.addAll(arrSpot);
							arrSpots.add(arrSpot);
						}
					}
				}
			}
		arrSpots.add(0, allSpot);
		req.setAttribute("arrSpots", arrSpots);
		
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	} 
	
	
	public void getResult(HttpServletRequest req) {
		try {
			// 파라미터값 가져오기
			String Q2 = req.getParameter("Q2");
			req.setAttribute("when", Q2);
			String Q4 = req.getParameter("Q4");
			req.setAttribute("cats", Q4);
			
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
			
			
			
			// 빈 지역 리스트 생성
			List<BigDecimal> locs = new ArrayList<BigDecimal>();
			
			// 빈 카테고리 리스트
			List<BigDecimal> cats = new ArrayList<BigDecimal>();
			
			// 빈 맵 생성(지역 - 일치 갯수)
			final Map<BigDecimal, Integer> map = new HashMap<BigDecimal, Integer>();
			// 정렬 후 리스트
			List<BigDecimal> keySet;
			// 지역 이름 리스트
			List<String> locNames;
			
			// 사진 리스트
			List<String> photos;
			
			// 결과 리스트(l_photo)
			List<List<String>> resultPhotoList = new ArrayList<List<String>>();
			
			// 결과 리스트(l_no)
			List<List<BigDecimal>> resultNumList = new ArrayList<List<BigDecimal>>();
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
						photos = new ArrayList<String>();
						// 카테고리 이름도 가져오기
						locNames.add(ss.getMapper(RecommendLocMapper.class).getCatName(acts.get(i)));
						photos.add("index0");
						// ketset(지역코드)에 따라 지역 이름 조회 후 locNames에 추가
						for (BigDecimal key : keySet) {
							locNames.add(ss.getMapper(RecommendLocMapper.class).getLocName(key));
							photos.add(URLDecoder.decode(ss.getMapper(LocationMapper.class).getLocationImage(key.toString()),"UTF-8"));
						}
						// keySet 맨 앞에 액티비티 코드 추가
						keySet.add(0, acts.get(i));
						resultNumList.add(keySet);
						resultList.add(locNames);
						resultPhotoList.add(photos);
						
					}
					req.setAttribute("resultNumList", resultNumList);
					req.setAttribute("resultList", resultList);
					req.setAttribute("resultPhotoList", resultPhotoList);
					
					
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
					photos = new ArrayList<String>();
//					int mapVal = map.get(keySet.get(0));
//					System.out.println(mapVal);
//					int count = 0;
					// ketset(지역코드)에 따라 지역 이름 조회 후 locNames에 추가
					for (BigDecimal key : keySet) {
//						System.out.println(key + ":" + map.get(key));
						locNames.add(ss.getMapper(RecommendLocMapper.class).getLocName(key));
						photos.add(URLDecoder.decode(ss.getMapper(LocationMapper.class).getLocationImage(key.toString()),"UTF-8"));
					}
					req.setAttribute("resultListNoActs", locNames);
					req.setAttribute("resultNumListNoActs", keySet);
					req.setAttribute("resultPhotoListNoActs", photos);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
