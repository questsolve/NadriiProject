package com.yagn.nadrii.service.trip.impl;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.yagn.nadrii.common.Search;
import com.yagn.nadrii.service.domain.Trip;
import com.yagn.nadrii.service.trip.TripDao;
import com.yagn.nadrii.service.trip.domain.TourApiDomain;
import com.yagn.nadrii.service.trip.urlmanage.TourAPIGetDetailUrlManage;
import com.yagn.nadrii.service.trip.urlmanage.TourAPIGetUrlManage;
import com.yagn.nadrii.service.trip.urlmanage.TourAPlListUrlManage;


@Repository("tripDaoImpl")
public class TripDaoImplTour implements TripDao {

	private TripDaoImplImageSearch tripDaoImplImageSearch;
	
	public TripDaoImplTour() {
		System.out.println(this.getClass());		
	}

	public List listTrip(int pageNo, String contentTypeId, String cat1,String cat2, String cat3,String areaCode, String localName) throws Exception {

		System.out.println(pageNo+ "  DAOIMPLEMENT");
		System.out.println("listTrip Dao parameter areaCode, localName");
		
		TourAPlListUrlManage tourAPlUrlManage= new TourAPlListUrlManage();
		tourAPlUrlManage.setPageNo(pageNo);
		tourAPlUrlManage.setContentTypeId(contentTypeId);
		tourAPlUrlManage.setCat1(cat1);
		tourAPlUrlManage.setCat2(cat2);
		tourAPlUrlManage.setCat3(cat3);
		tourAPlUrlManage.setAreaCode(areaCode);
		tourAPlUrlManage.setSigunguCode(localName);
		tourAPlUrlManage.setType("areaBasedList?");

		System.out.println(tourAPlUrlManage.urlMaking());
		
		HttpClient httpClient = new DefaultHttpClient();
		List list = new ArrayList();
				
		HttpGet httpGet = new HttpGet(tourAPlUrlManage.urlMaking()); 
		
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
				
		HttpEntity httpEntity = httpResponse.getEntity();
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
			
		ObjectMapper objectMapper = new ObjectMapper();
		
		JSONObject jsonobj = (JSONObject) JSONValue.parse(br);

		JSONObject response = (JSONObject) jsonobj.get("response");

		JSONObject header = (JSONObject) response.get("header");

		JSONObject body = (JSONObject) response.get("body");
		System.out.println("[4 : body] ==>" + body);
		
		//데이터가 잘 넘어 온 경우
		if(body.get("items") instanceof JSONObject) {
			JSONObject items = (JSONObject) body.get("items");
			
			//데이터가 여러개인 경우
			if(items.get("item") instanceof JSONArray) {
				JSONArray jsonArray = (JSONArray)items.get("item");
				
				tripDaoImplImageSearch = new TripDaoImplImageSearch();
						
				for(int i=0;i<jsonArray.size();++i) {
					JSONObject obj = (JSONObject)jsonArray.get(i);
					System.out.println(obj);
							
					TourApiDomain tourDomain = new TourApiDomain();
					tourDomain = objectMapper.readValue(obj.toJSONString(), TourApiDomain.class);
					System.out.println(tourDomain);
					
					if(tourDomain.getFirstimage2()==null) {
						System.out.println("이미지가 없음-->>  "+tourDomain.getTitle());
						String image = tripDaoImplImageSearch.naverImageSearch(tourDomain.getTitle());
						System.out.println(image);
						tourDomain.setFirstimage2(image);
					}
								
					list.add(tourDomain);
					System.out.println(list.get(i));
				}
				
			//데이터가 한개 인경우	
				
			}else {
				JSONObject jsonObject = (JSONObject)items.get("item");
				TourApiDomain tourDomain = new TourApiDomain();
				tourDomain = objectMapper.readValue(jsonObject.toJSONString(), TourApiDomain.class);
				if(tourDomain.getFirstimage2() ==null) {
					tripDaoImplImageSearch = new TripDaoImplImageSearch();
					System.out.println("이미지가 없음-->>  "+tourDomain.getTitle());
					String image = tripDaoImplImageSearch.naverImageSearch(tourDomain.getTitle());
					System.out.println(image);
					tourDomain.setFirstimage2(image);
				}
				
				list.add(tourDomain);
				
				
				
			}
		//전달 데이터가 없는 경우	
		}else {
			
		}
		return list;
	}
	
	
	
	
	@Override
	public TourApiDomain getTrip(String contentId, String contentTypeId) throws Exception {
		
		TourAPIGetUrlManage tourAPIGetUrlManage = new TourAPIGetUrlManage();
		tourAPIGetUrlManage.urlClean();
		tourAPIGetUrlManage.setContentId(contentId);
		tourAPIGetUrlManage.setContentTypeId(contentTypeId);
		System.out.println(tourAPIGetUrlManage.urlMaking());
		
		//기본 정보가져오기
		HttpClient httpClient = new DefaultHttpClient();
		HttpGet httpGet = new HttpGet(tourAPIGetUrlManage.urlMaking()); 
		
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		HttpResponse httpResponse = httpClient.execute(httpGet);
				
		HttpEntity httpEntity = httpResponse.getEntity();
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(br);
		JSONObject response = (JSONObject) jsonObject.get("response");
		JSONObject header = (JSONObject) response.get("header");
		JSONObject body = (JSONObject) response.get("body");
		JSONObject items = (JSONObject) body.get("items");
		JSONObject jsonobj = (JSONObject)items.get("item");
		ObjectMapper objectMapper = new ObjectMapper();
		TourApiDomain tourApiDomain = objectMapper.readValue(jsonobj.toJSONString(), TourApiDomain.class);
		
		return tourApiDomain;		
	}

	@Override
	public TourApiDomain getTripDetail(String contentId, String contentTypeId) throws Exception {

		//요금정보 가져오기
		TourAPIGetDetailUrlManage tourAPIGetDetailUrlManage = new TourAPIGetDetailUrlManage();
		tourAPIGetDetailUrlManage.urlClean();
		tourAPIGetDetailUrlManage.setContentId(contentId);
		tourAPIGetDetailUrlManage.setContentTypeId(contentTypeId);
		
		System.out.println(tourAPIGetDetailUrlManage.urlMaking());
		
		HttpClient httpClient = new DefaultHttpClient();
		HttpGet httpGet = new HttpGet(tourAPIGetDetailUrlManage.urlMaking());
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
				
		HttpResponse httpResponse = httpClient.execute(httpGet);
		HttpEntity httpEntity = httpResponse.getEntity();
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(br);
//		System.out.println(jsonObject);
		JSONObject response = (JSONObject) jsonObject.get("response");
		JSONObject header = (JSONObject) response.get("header");
		JSONObject body = (JSONObject) response.get("body");
//		System.out.println(body);
		JSONObject items = (JSONObject) body.get("items");
		JSONObject jsonobj = (JSONObject)items.get("item");	
//		System.out.println(jsonobj);
		
		ObjectMapper objectMapper = new ObjectMapper();
		TourApiDomain tourApiDomain = objectMapper.readValue(jsonobj.toJSONString(), TourApiDomain.class);
				
		return tourApiDomain;
	}
	
	
	public String getAreaCode(String placeName, String areaCode) throws Exception{
		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode";
		
		String myKey = "ay3zIymuP5LX%2BGZhKC44TDdl68jrGAk5sMJ2Ry5GkBV0TvUP14kU13EG1mkNneM4GQOTPDsVuj2%2BCKLpcwcvfg%3D%3D";

		String serviceKey = "?ServiceKey=" + myKey;				
		String mobileOS = "&MobileOS=ETC"; 						
		String mobileApp = "&MobileApp=AppTest"; 
		int numOfRows = 200;
		
				
		HttpClient httpClient = new DefaultHttpClient();
		HttpGet httpGet = new HttpGet( url + serviceKey + mobileOS + mobileApp
				+ "&areaCode=" + areaCode
				+ "&numOfRows=" + numOfRows
				);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
				
		HttpResponse httpResponse = httpClient.execute(httpGet);
		HttpEntity httpEntity = httpResponse.getEntity();
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		JSONObject jsonObject = (JSONObject)JSONValue.parse(br);
//		System.out.println(jsonObject);
		JSONObject response = (JSONObject) jsonObject.get("response");
		JSONObject header = (JSONObject) response.get("header");
		JSONObject body = (JSONObject) response.get("body");
//		System.out.println(body);
		JSONObject items = (JSONObject) body.get("items");
		JSONArray item = (JSONArray)items.get("item");	
		//System.out.println("[6 : item] ==>" + item);
		List list = new ArrayList();
		Map map = new HashMap();
		
		for (int i = 0; i < item.size(); i++) {
			String parameter = ((JSONObject)item.get(i)).get("code").toString();
			//System.out.println(parameter);
			String key = ((JSONObject)item.get(i)).get("name").toString();
			//System.out.println(key+" : "+parameter);
			map.put(key, parameter);
		}
		
		
		return (String)map.get(placeName);
		
	}
	
	
	
	
	

	@Override
	public String naverImageSearch(String target) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void addTrip(Trip trip) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Trip getTrip(int postNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Trip> listTrip(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateViewCount(String contentId) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Trip getTripFromDB(String contentId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List getClientAddress(String lat, String lng) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	
}
