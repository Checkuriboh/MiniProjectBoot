package com.model2.mvc.service.product;

import java.util.Map;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductService {
	
		// void
	public Product addProduct(Product productVO) throws Exception;
	
	public Product getProduct(int prodNo) throws Exception;
	
	public Map<String, Object> getProductList(Search search) throws Exception;

		// void
	public Product updateProduct(Product productVO) throws Exception;

	public ResponseEntity<Resource> getProductFile(String fileName) throws Exception;
	
	public void setProductFile(Product product, MultipartFile fileData) throws Exception;
	
}
