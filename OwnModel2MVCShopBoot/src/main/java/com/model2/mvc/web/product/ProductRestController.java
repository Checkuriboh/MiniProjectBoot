package com.model2.mvc.web.product;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


//==> 상품관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Value("${pageSize:3}")
	private int pageSize;
	
	
	///Constructor
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	
	//==> 상품번호를 받아 상품정보 검색 및 반환
	@GetMapping("json/getProduct/{prodNo}")
	public Product getProduct( @PathVariable int prodNo ) throws Exception
	{
		System.out.println("/product/json/getProduct : GET");
		
		return productService.getProduct(prodNo);
	}
	
	//==> <img src=""> 상품 이미지 반환
	@GetMapping("json/getImageFile/{fileName:.+}")
	public ResponseEntity<Resource> getImageFile( @PathVariable String fileName ) throws Exception
	{
		System.out.println("/product/json/getImageFile : GET");
		
        return productService.getProductFile(fileName);
    }
	
	/*
	 * //==> 상품목록 검색 후 확인 페이지로 이동
	 * 
	 * @RequestMapping(value="listProduct", method={RequestMethod.GET,
	 * RequestMethod.POST}) public String listProduct( @ModelAttribute Search
	 * search, Model model ) throws Exception {
	 * System.out.println("/product/listProduct : GET / POST");
	 * 
	 * if (search.getCurrentPage() == 0 ) { search.setCurrentPage(1); }
	 * search.setPageSize(pageSize);
	 * 
	 * // Business logic 수행 Map<String, Object> map =
	 * productService.getProductList(search);
	 * 
	 * Page resultPage = new Page(search.getCurrentPage(),
	 * ((Integer)map.get("totalCount")), pageUnit, pageSize);
	 * System.out.println(resultPage);
	 * 
	 * // Model 과 View 연결 model.addAttribute("list", map.get("list"));
	 * model.addAttribute("resultPage", resultPage); model.addAttribute("search",
	 * search);
	 * 
	 * return "forward:/product/listProduct.jsp"; }
	 */
	
}