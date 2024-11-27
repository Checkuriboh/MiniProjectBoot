package com.model2.mvc.web.product;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


//==> 상품관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	
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
	
}
