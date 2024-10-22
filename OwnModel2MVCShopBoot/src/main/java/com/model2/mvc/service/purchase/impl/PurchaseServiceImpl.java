package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;


@Service("purchaseServiceImpl")
@Transactional
public class PurchaseServiceImpl implements PurchaseService {
	
	///field
	@Autowired
	//@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;

	
	///constructor
	public PurchaseServiceImpl() {
		System.out.println(this.getClass());
	}

	
//	///setter
//	public void setPurchaseDao(PurchaseDao purchaseDao) {
//		this.purchaseDao = purchaseDao;
//	}


	/// method
	@Override
	public Purchase addPurchase(Purchase purchase) throws Exception {
		purchaseDao.addPurchase(purchase);
		return purchase;
	}

	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		return purchaseDao.getPurchase(tranNo);
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception
	{
		List<Purchase> list = purchaseDao.getPurchaseList(search, buyerId);
		int totalCount = purchaseDao.getTotalCount(search, buyerId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", totalCount);
		
		return map;
	}

	@Override
	public Map<String, Object> getSaleList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Purchase updatePurchase(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);
		return purchase;
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		purchaseDao.updateTranCode(purchase);
	}

}
