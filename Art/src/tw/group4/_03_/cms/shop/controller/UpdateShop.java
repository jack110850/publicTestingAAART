package tw.group4._03_.cms.shop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import tw.group4._03_.cms.shop.model.CreativeShopBean;
import tw.group4._03_.cms.shop.model.CreativeShopService;
import tw.group4._03_.cms.util.CustomizedTypeConversion;
import tw.group4.util.Hibernate;

@Controller
public class UpdateShop {

	@Autowired
	public CreativeShopService css;
	
	@Hibernate
	@RequestMapping(path = "/03/cms/shop/updateShopByShopId.ctrl", method = RequestMethod.POST)
	public String updateShopByShopId(@RequestParam(name = "shopId") String shopId, Model m) {
		
		try {
			int id = Integer.parseInt(shopId);
			List<CreativeShopBean> shopsList = css.selectByShopId(id);
			
//			CreativeShopBean a = shopsList.get(0);
//			System.out.println(a);
			
			if (shopsList.size() != 0) {
				m.addAttribute("acShopsList", shopsList);
			} else {
				String acShopsSerachMsg = "查無此商店資料，請重新查詢";
				m.addAttribute("acShopsSerachMsg", acShopsSerachMsg);
			}
		} catch (Exception e) {
			e.printStackTrace();
			
			String acShopsSerachMsg = "查無此商店編號";
			m.addAttribute("acShopsSerachMsg", acShopsSerachMsg); // 回傳錯誤訊息
		}
		return "03/cms_shop/update_confirm";
		
	}
	
	@Hibernate
	@RequestMapping(path = "/03/cms/shop/updateShop.ctrl", method = RequestMethod.POST)
	public String updateShop( 
			@RequestParam(name="shopId") String shopId,
			@RequestParam(name="shopName") String shopName, 
			@RequestParam(name="memberId") String memberId, 
			@RequestParam(name="image") String image,
			@RequestParam(name="intro") String intro, 
			
			@RequestParam(name="cityName") String cityName,
			@RequestParam(name="address") String address,
			@RequestParam(name="openTime") String openTime,
			@RequestParam(name="phone") String phone,
			@RequestParam(name="fax") String fax,
			
			@RequestParam(name="email") String email,
			@RequestParam(name="facebook") String facebook,
			@RequestParam(name="website") String website,
			@RequestParam(name="clicks") String clicks,
			@RequestParam(name="reservation") String reservation,
		
			Model m) {
		try {

			int intShopId = Integer.parseInt(shopId);
			int intMemberId = 1;
			int intClicks = CustomizedTypeConversion.customizedParseInt(clicks);
			int intReservation = 0;

			// 執行更新
			css.update(intShopId, shopName, intMemberId, image, intro, 
					cityName, address, openTime, phone, fax, email, facebook,
					website, intClicks, intReservation);

			String acShopsUpdateMsg = "商店資料更新成功";
			m.addAttribute("acShopsUpdateMsg", acShopsUpdateMsg);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "03/cms_shop/update_return";
	}


//	@RequestMapping(path = "/03/cms/shop/updateShopByShopName.ctrl", method = RequestMethod.POST)
//	public String updateShopByShopName(@RequestParam(name = "shopName") String shopName, Model m) {
//
//		try {
//			List<CreativeShopBean> shopsList = css.selectByShopName(shopName);
//
//			if (shopsList.size() != 0) {
//				m.addAttribute("acShopsList", shopsList);
//			} else {
//				String acShopsSerachMsg = "查無此商店資料，請重新查詢";
//				m.addAttribute("acShopsSerachMsg", acShopsSerachMsg);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//
//			String acShopsSerachMsg = "查無此商店名稱";
//			m.addAttribute("acShopsSerachMsg", acShopsSerachMsg); // 回傳錯誤訊息
//		}
//		return "03/cms_shop/update_by_name";
//
//	}

}
