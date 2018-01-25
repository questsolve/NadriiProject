package com.yagn.nadrii.service.ticket.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yagn.nadrii.common.OpenApiSearch;
import com.yagn.nadrii.service.domain.DetailImage;
import com.yagn.nadrii.service.domain.DetailIntro;
import com.yagn.nadrii.service.ticket.TicketService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-common.xml", 
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml", 
										"classpath:config/context-transaction.xml" })
public class TicketServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("ticketServiceImpl")
	private TicketService ticketService;

	//@Test
	public void testGetTicketListAll() throws Exception {

		OpenApiSearch openApiSearch = new OpenApiSearch();
		openApiSearch.setPageNo(4);
		
		Map<String, Object> map = ticketService.getTicketList(openApiSearch);

		@SuppressWarnings("unchecked")
		List<Object> list = (List<Object>) map.get("tourTicketList");
		Assert.assertEquals(10, list.size());

		// ==> console Ȯ��
		System.out.println("[testGetTicketListAll] : " + list);

	}
	 
	//@Test
	public void testGetTicket() throws Exception {

//		int contentId = 790124;
//		int contentTypeId = 15;
		int contentId = 2531711;
		int contentTypeId = 15;
		
		DetailIntro detailIntro = new DetailIntro(); 
		detailIntro = ticketService.getTicket(contentId, contentTypeId);
		
		// ==> console Ȯ��
		System.out.println("[testGetTicket] : " + detailIntro);

		// ==> API Ȯ��
		Assert.assertEquals(2531711, detailIntro.getContentid());
		Assert.assertEquals(15, detailIntro.getContenttypeid());
//		Assert.assertEquals("������ ȫõ ���û긲���� �丮��", detailIntro.getEventplace());
//		Assert.assertEquals("�Ϻ� ���α׷� ����", detailIntro.getUsetimefestival());

	}
	
	@Test
	public void testGetDetailImage() throws Exception {

		int contentId = 1815964;		// ������ ID :	
//		int contentId = 737479;			// ������ ID	:
//		int contentId = 2531711;		// ������ ID	:

		DetailImage detailImage = new DetailImage();
		detailImage = ticketService.getDetailImage(contentId);

		// ==> console Ȯ��
		System.out.println("[testGetDetailImage] : " + detailImage);

		// ==> API Ȯ��
//		Assert.assertEquals(null, detailImage.getContentid());
	
	}
	 
} // end of class