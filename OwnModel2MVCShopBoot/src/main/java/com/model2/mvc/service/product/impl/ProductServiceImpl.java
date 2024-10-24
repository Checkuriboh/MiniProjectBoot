package com.model2.mvc.service.product.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

	// �̹��� ���� ���� dirPath
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

	@Override
	public ResponseEntity<Resource> getProductFile(String fileName) throws Exception
	{
        try {
            // ���� �ý��ۿ��� �̹����� ã�� ���� ��� ����
            Path imagePath = Paths.get(fileDir + fileName);
            Resource resource = (Resource) new UrlResource(imagePath.toUri());

            // �̹����� �����ϴ��� Ȯ��
            if ( !resource.exists() ) {
            	// �̹����� ������ 404 error
                imagePath = Paths.get(fileDir + "404image.jpg");
                resource = (Resource) new UrlResource(imagePath.toUri());
                //return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            // �̹��� ������ Content-Type ���� (JPEG, PNG ��)
            String contentType = Files.probeContentType(imagePath);
	        	
            // �̹��� �����͸� ResponseEntity�� ��ȯ
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType)) // Content-Type ����
                    .body(resource); // �̹��� ���ҽ� ��ȯ

        } catch (Exception e) {
        	// ���� �� ��Ȳ 500 error
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
	
	@Override
	public void setProductFile(Product product, MultipartFile fileData) throws Exception
	{
		// ���ε� �� ������ �����ϸ� ����
		if ( !fileData.isEmpty() ) 
		{
			// ���� �̸����� ������ ID �ο�
			String fileName = UUID.randomUUID().toString() + "." + fileData.getContentType().substring(6);
					
			try {
				// ���� ���� + ���� �� ��ǰ�� ���� �̸� ����
				fileData.transferTo(new File(fileDir, fileName));
				product.setFileName(fileName);
						
			} catch (IOException e) {
				// ���� ���� ���� �� �� ���� ����
				product.setFileName("noimage.jpg");
				e.printStackTrace();
			}
		}
		else { // ���ε� �� ������ ������ �� ���� ����
			product.setFileName("noimage.jpg");
		//	product.setFileName("../../images/empty.GIF");
		}
	}

}
