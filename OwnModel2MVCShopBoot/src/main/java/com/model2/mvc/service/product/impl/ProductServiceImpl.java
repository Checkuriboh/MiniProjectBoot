package com.model2.mvc.service.product.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;


@Service("productServiceImpl")
@Transactional
public class ProductServiceImpl implements ProductService {
	
	///field
	@Autowired
	//@Qualifier("productDaoImpl")
	private ProductDao productDao;

	// 이미지 파일 참조 dirPath
	@Value("${file.dir:C:/uploadFiles/}")
	private String fileDir;
	
	
	///constructor
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}
	
	
//	///setter
//	public void setProductDao(ProductDao productDao) {
//		this.productDao = productDao;
//	}
	
	
	///method

	@Override
	public Product addProduct(Product product) throws Exception {
		productDao.addProduct(product);
		return product;
	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		return productDao.getProduct(prodNo);
	}

	@Override
	public Product updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);
		return product;
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception
	{
		List<Product> list = productDao.getProductList(search);
		int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", totalCount);
		
		return map;
	}
	
	public void saveProductFile(Product product, MultipartFile fileData) throws Exception
	{
		// 업로드 된 파일이 존재하면 저장
		if ( !fileData.isEmpty() ) 
		{
			// 파일 이름으로 랜덤한 ID 부여
			String fileName = UUID.randomUUID().toString() + "." + fileData.getContentType().substring(6);
					
			try {
				// 파일 저장 + 성공 시 상품에 파일 이름 저장
				fileData.transferTo(new File(fileDir, fileName));
				product.setFileName(fileName);
						
			} catch (IOException e) {
				// 파일 저장 실패 시 빈 파일 저장
				e.printStackTrace();
				product.setFileName("empty.GIF");
			}
		}
		else { // 업로드 된 파일이 없으면 빈 파일 저장
			product.setFileName("empty.GIF");
//			product.setFileName("../../images/empty.GIF");
		}
	}

}
