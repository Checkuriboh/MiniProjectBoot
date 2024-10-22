package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 상품관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Value("${pageUnit:3}")
	private int pageUnit;
	
	@Value("${pageSize:3}")
	private int pageSize;
	
	
	///Constructor
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	
	//==> 상품정보 추가 페이지로 이동
	@GetMapping("addProduct")
	public String addProduct() throws Exception
	{
		System.out.println("/product/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	//==> 상품정보 추가 B/L 수행
	@PostMapping("addProduct")
	public String addProduct( @ModelAttribute Product product,
							  @RequestParam MultipartFile fileData ) throws Exception
	{
		System.out.println("/product/addProduct : POST");

		// 업로드 된 파일 저장 + 파일 이름 설정
		productService.saveProductFile(product, fileData);
		// 상품 정보 추가 B/L 수행
		productService.addProduct(product);

		return "redirect:/product/listProduct?menu=manage";
	}

	//==> 상품정보 확인 페이지로 이동
	@GetMapping("getProduct")
	public String getProduct( @RequestParam int prodNo,
							  Model model ) throws Exception
	{
		System.out.println("/product/getProduct : GET");

		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp";
	}

	//==> 상품정보 수정 페이지로 이동
	@GetMapping("updateProduct")
	public String updateProduct( @RequestParam int prodNo,
								 Model model ) throws Exception
	{
		System.out.println("/product/updateProduct : GET");

		Product product = productService.getProduct(prodNo);

		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}

	//==> 상품정보 수정 B/L 수행
	@PostMapping("updateProduct")
	public String updateProduct( @ModelAttribute Product product, 
								 @RequestParam MultipartFile fileData ) throws Exception
	{
		System.out.println("/product/updateProduct : POST");

		if ( !fileData.isEmpty() ) {
			// 업로드 된 파일 저장 + 파일 이름 설정
			productService.saveProductFile(product, fileData);
		}
		// 상품 정보 갱신 B/L 수행
		productService.updateProduct(product);

		return "redirect:/product/getProduct?prodNo=" + product.getProdNo();
	}
	
	//==> 상품목록 검색 후 확인 페이지로 이동
	@RequestMapping(value="listProduct", method={RequestMethod.GET, RequestMethod.POST})
	public String listProduct( @ModelAttribute Search search, 
							   Model model ) throws Exception
	{
		System.out.println("/product/listProduct : GET / POST");
		
		if (search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String, Object> map = productService.getProductList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/product/listProduct.jsp";
	}
	
}