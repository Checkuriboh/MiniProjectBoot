package com.model2.mvc.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;


@Aspect
public class LogAspectJ {

	/// Constructor
	public LogAspectJ() {
		System.out.println("Common :: "+this.getClass());
	}
	
	@Around("execution(* com.model2.mvc.service..*Impl.*(..) )") 
	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable {
			
		System.out.println("");
		System.out.println("[Around before] 타겟객체 메서드:"+
													joinPoint.getTarget().getClass().getName() +"."+
													joinPoint.getSignature().getName());
		if(joinPoint.getArgs().length !=0){
			System.out.println("[Around before] method에 전달되는 인자: "+ joinPoint.getArgs()[0]);
		}
		//==> 타겟 객체의 Method 를 호출 하는 부분 
		Object obj = joinPoint.proceed();

		System.out.println("[Around after] 타겟객체 return value: "+obj);
		System.out.println("");
		
		return obj;
	}
	
}//end of class