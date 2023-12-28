package com.app.dto;

import lombok.Data;

@Data
public class LikeListDTO {
    private int like_list_id;
    UserDTO user_id;
    PropertyServiceDTO property_service_id; 
    PropertyDTO property_id; 
}