package com.app.dto;

import lombok.Data;
@Data
public class MainSearchDto {
	
		private int page;             // 현재 페이지 번호
	    private int recordSize;       // 페이지당 출력할 데이터 개수
	    private int pageSize;// 화면 하단에 출력할 페이지 사이즈
	    private String keyword;       // 검색 키워드
	    private String searchType;    // 검색 유형
	    private int deal; //1
	    private int jeonse; //2
	    private int wolse; //3
	    private String dealAmount;
	    private String jeonseAmount;
	    private String wolseAmount;
	    private String feetAmount;
	    private PaginationDto paginationDto; //페이지정보
	    private int dealPriceMin;
	    private int dealPriceMax;
	    private int jeonsePriceMin;
	    private int jeonsePriceMax;
	    private int wolsePriceMin;
	    private int wolsePriceMax;
	    private int feetMin;
	    private int feetMax;
	   
	    
	    public MainSearchDto() {
	        this.page = 1;
	        this.recordSize = 10;
	        this.pageSize = 10;
	    }

	 // 가격 범위 문자열 숫자 변환
	    public void parsePriceRanges() {
	        int[] dealPrices = parsePriceRange(this.dealAmount);
	        this.dealPriceMin = dealPrices[0];
	        this.dealPriceMax = dealPrices[1];

	        int[] jeonsePrices = parsePriceRange(this.jeonseAmount);
	        this.jeonsePriceMin = jeonsePrices[0];
	        this.jeonsePriceMax = jeonsePrices[1];

	        int[] wolsePrices = parsePriceRange(this.wolseAmount);
	        this.wolsePriceMin = wolsePrices[0];
	        this.wolsePriceMax = wolsePrices[1];
	        
	        int[] feetPrices = parseFeet(this.feetAmount);
	        this.feetMin = feetPrices[0];
	        this.feetMax = feetPrices[1];
	    }

	    // 개별 가격 문자열을 숫자로 변환
	    private int[] parsePriceRange(String priceRange) {
	        if (priceRange == null) {
	            return new int[]{0, 9999999};
	        }

	        int minPrice = 0;
	        int maxPrice = 0;

	        String[] ranges = priceRange.split(" - ");
	        if (ranges.length == 2) {
	        	if(ranges[1].equals("무제한")) {
	        		maxPrice=9999999;
	        	}else {
	            maxPrice = parsePrice(ranges[1]);
	            }
	            minPrice = parsePrice(ranges[0]);

	        }

	        return new int[]{minPrice, maxPrice};
	    }
	    
	    private int[] parseFeet(String feetRange) {
	    	 if (feetRange == null) {
		            return new int[]{0, 9999999};
		        }

		        int minPrice = 0;
		        int maxPrice = 0;

		        String[] ranges = feetRange.split(" - ");
		        if (ranges.length == 2) {
		        	if(ranges[1].equals("무제한")) {
		        		maxPrice=9999999;
		        	}else {
		            maxPrice = Integer.parseInt(ranges[1].replace("평", ""));
		            }
		            minPrice = Integer.parseInt(ranges[0].replace("평", ""));

		        }

		        return new int[]{minPrice, maxPrice};
	    }

	    // 문자열에서 숫자를 추출하여 가격 계산
	    private int parsePrice(String price) {
	        if (price.contains("억")) {
	            String[] parts = price.split("억");
	            int billions = Integer.parseInt(parts[0]) * 10000;

	            if (parts.length > 1 && parts[1].contains("천만원")) {
	                int tenMillions = Integer.parseInt(parts[1].replace("천만원", "").trim()) * 1000;
	                return billions + tenMillions;
	            }

	            return billions;
	         
	 
	        }
	        else if(price.contains("천만원")){
	        	String[] parts = price.split("천만원");
	        	int tenMillions = Integer.parseInt(parts[0]) * 1000;
	        	return tenMillions;
	        
        	}
	        
	        else if (price.contains("만원")) {
	            return Integer.parseInt(price.replace("만원", "").trim());
	        }

	        return 0;
	    }
}



