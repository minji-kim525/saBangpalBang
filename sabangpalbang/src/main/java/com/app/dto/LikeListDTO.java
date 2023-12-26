package com.app.dto;

import lombok.Data;

@Data
public class LikeListDTO {
    private int like_list_id;
    private int user_id;
    private Integer property_service_id; 
    private Integer property_id; 
}