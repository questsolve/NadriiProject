package com.yagn.nadrii.service.purchase.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.yagn.nadrii.common.OpenApiSearch;
import com.yagn.nadrii.service.domain.KakaoPayRequest;
import com.yagn.nadrii.service.domain.KakaoPayResponse;
import com.yagn.nadrii.service.domain.Purchase;
import com.yagn.nadrii.service.purchase.PurchaseDao;
import com.yagn.nadrii.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {
	
	/// Field
		@Autowired
		@Qualifier("purchaseDaoImpl")
		private PurchaseDao purchaseDao;
		
		public void setPurchaseDao(PurchaseDao purchaseDao) {
			this.purchaseDao = purchaseDao;
		}
		
		@Autowired
		@Qualifier("purchaseKakaoDaoImpl")
		private PurchaseDao purchaseKakaoDao;
		
		public void setPurchaseKakaoDao(PurchaseDao purchaseKakaoDao) {
			this.purchaseKakaoDao = purchaseKakaoDao;
		}
		
		
		/// Constructor
		public PurchaseServiceImpl() {
			System.out.println(this.getClass());
		}

		@Override
		public void addPurchase(Purchase purchase) throws Exception {
			
			if (purchase.getTicketPriceAll() == null) {
				String sumTicketPrice = "";
				for (int i = 0; i < purchase.getTicketPrice().length; i++) {
					String ticketCount = purchase.getTicketCount()[i];
					String ticketPrice = purchase.getTicketPrice()[i];
					
					sumTicketPrice += ticketPrice + "=" + ticketCount + "&";
				} 
				purchase.setTicketPriceAll(sumTicketPrice);
			}
			
			purchaseDao.addPurchase(purchase);
		}

		@Override
		public Map<String, Object> getBasketList(OpenApiSearch openApiSearch, String buyerId) throws Exception {
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("openApiSearch", openApiSearch);
			map.put("buyerId", buyerId);
			
			List<Purchase> list =  purchaseDao.getBasketList(map);
			List<String> count = new ArrayList<>();
			List<String> price = new ArrayList<>();
			
			for (int i = 0; i < list.size(); i++) {
				String firstParseArr[] = list.get(i).getTicketPriceAll().split("&");
				
				price = new ArrayList<>();	
				count = new ArrayList<>();
				
				for (int j = 0; j < firstParseArr.length; j++) {
					String secondParseArr[] = firstParseArr[j].split("=");

					for (int k = 0; k < secondParseArr.length; k++) {
						
						if (k == 0) {
							price.add(secondParseArr[k].toString());
						} else if (k == 1) {
							count.add(secondParseArr[k].toString());
						}
					}
				}
				list.get(i).setTicketC(count);
				list.get(i).setTicketP(price);
			}
			
			int totalCount = purchaseDao.getTotalCount(buyerId);
			
			map.put("list", list);
			map.put("totalCount", new Integer(totalCount));
			
			return map;
		}
		
		@Override
		public KakaoPayResponse addKakaoPayment(KakaoPayRequest kakaoPayRequest) throws Exception {
			return purchaseKakaoDao.addKakaoPayment(kakaoPayRequest);
		}
		
		@Override
		public KakaoPayResponse addKakaoPayComplete(KakaoPayRequest kakaoPayRequest) throws Exception {
			return purchaseKakaoDao.addKakaoPayComplete(kakaoPayRequest);
		}
		
}
