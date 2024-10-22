package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;


//==> 판매관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Value("${pageUnit:3}")
	private int pageUnit;
	
	@Value("${pageSize:3}")
	private int pageSize;
	
	
	///Constructor
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	
	//==> 판매정보 추가 페이지로 이동
	@GetMapping("addPurchase")
	public ModelAndView addPurchase( @RequestParam int prodNo, 
									 HttpSession session ) throws Exception
	{
		System.out.println("/purchase/addPurchase : GET");
		
		User user = (User)session.getAttribute("user");
		Product product = productService.getProduct(prodNo);

		ModelAndView mav = new ModelAndView();
		mav.addObject("user", user);
		mav.addObject("product", product);
		mav.setViewName("forward:/purchase/addPurchaseView.jsp");
		
		return mav;
	}

	//==> 판매정보 추가 B/L 수행
	@PostMapping("addPurchase")
	public ModelAndView addPurchase( @ModelAttribute User user, 
									 @ModelAttribute Product product, 
									 @ModelAttribute Purchase purchase ) throws Exception
	{
		System.out.println("/purchase/addPurchase : POST");

		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setTranCode("1");
		
		purchaseService.addPurchase(purchase);

		String viewName = "forward:/purchase/addPurchase.jsp";
		
		return new ModelAndView(viewName, "purchase", purchase);
	}
	
	//==> 판매정보 확인 페이지로 이동
	@GetMapping("getPurchase")
	public ModelAndView getPurchase( @RequestParam int tranNo ) throws Exception
	{
		System.out.println("/purchase/getPurchase : GET");

		Purchase purchase = purchaseService.getPurchase(tranNo);

		String viewName = "forward:/purchase/getPurchase.jsp";
		
		return new ModelAndView(viewName, "purchase", purchase);
	}

	//==> 판매정보 수정 페이지로 이동
	@GetMapping("updatePurchase")
	public ModelAndView updatePurchase( @RequestParam int tranNo ) throws Exception
	{
		System.out.println("/purchase/updatePurchase : GET");

		Purchase purchase = purchaseService.getPurchase(tranNo);

		String viewName = "forward:/purchase/updatePurchase.jsp";
		
		return new ModelAndView(viewName, "purchase", purchase);
	}

	//==> 판매정보 수정 B/L 수행
	@PostMapping("updatePurchase")
	public ModelAndView updatePurchase( @ModelAttribute Purchase purchase ) throws Exception
	{
		System.out.println("/purchase/updatePurchase : POST");

		purchaseService.updatePurchase(purchase);

		String viewName = "redirect:/purchase/getPurchase";
		
		return new ModelAndView(viewName, "tranNo", purchase.getTranNo());
	}

	//==> 판매상태 수정 B/L 수행
	@GetMapping("updateTranCode")
	public ModelAndView updateTranCode( @RequestParam int tranNo,
										@RequestParam String tranCode ) throws Exception
	{
		System.out.println("/purchase/updateTranCode : GET");

		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranCode(purchase);
		
		return new ModelAndView("redirect:/purchase/listPurchase");
	}

	//==> 판매상태 수정 B/L 수행 (상품정보에서 접근 시)
	@GetMapping("updateTranCodeByProd")
	public ModelAndView updateTranCodeByProd( @RequestParam int prodNo,
											  @RequestParam String tranCode ) throws Exception
	{
		System.out.println("/purchase/updateTranCodeByProd : GET");

		Product product = new Product();
		product.setProdNo(prodNo);
		
		Purchase purchase = new Purchase();
		purchase.setPurchaseProd(product);
		purchase.setTranCode(tranCode);

		purchaseService.updateTranCode(purchase);

		String viewName = "redirect:/product/listProduct";
		
		return new ModelAndView(viewName, "menu", "manage");
	}

	//==> 판매목록 검색 후 확인 페이지로 이동
	@RequestMapping(value="listPurchase", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView listPurchase( @ModelAttribute Search search, 
									  HttpSession session ) throws Exception
	{
		System.out.println("/purchase/listPurchase : GET / POST");
		
		if (search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		User user = (User)session.getAttribute("user");
		Map<String, Object> map = purchaseService.getPurchaseList(search, user.getUserId());

		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")), pageUnit, pageSize);
		System.out.println(resultPage);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", map.get("list"));
		mav.addObject("resultPage", resultPage);
		mav.addObject("search", search);
		mav.setViewName("forward:/purchase/listPurchase.jsp");
		
		return mav;
	}
	
}