package com.app.dto;

import lombok.Data;

@Data
public class LikeListDTO {
    private int like_list_id;
    private int user_id;
    private int p_service_type;
    private int ps_service_type;
    private int property_service_id;
    private int property_id;}